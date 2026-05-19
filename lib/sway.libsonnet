{
  local NEWLINE = [''],
  local Optional(value, cond, default_value=[]) =
    (if cond then value else default_value),
  local OptionalNewline(cond, default_value=[]) =
    Optional(NEWLINE, cond, default_value),
  IndentBy(amt, c=' '):
    std.repeat(c, amt * (if c == ' ' then 2 else 1)),
  Comment(lines, newlineBefore=false, newlineAfter=false):
    OptionalNewline(newlineBefore) +
    [
      '# %(line)s' % { line: line }
      for line in (if std.isArray(lines) then lines else [lines])
    ] +
    OptionalNewline(newlineAfter),
  Include(paths):
    [
      'include %(path)s' % { path: p }
      for p in (if std.isArray(paths) then paths else [paths])
    ],
  Exec(cmds):
    [
      'exec %(cmd)s' % { cmd: cmd }
      for cmd in (if std.isArray(cmds) then cmds else [cmds])
    ],
  ExecAlways(cmds):
    [
      'exec_always %(cmd)s' % { cmd: cmd }
      for cmd in (if std.isArray(cmds) then cmds else [cmds])
    ],
  IncludeSystemConfig: self.Include('/etc/sway/config.d/*'),
  IncludeUserConfig: self.Include('~/.config/sway/custom.d/*'),
  Systemd(newlineBefore=false, newlineAfter=true):
    OptionalNewline(newlineBefore) +
    self.Comment([
      'start systemd services',
    ]) +
    self.Exec([
      'systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP XDG_SESSION_TYPE',
      'systemctl --user start sway-session.target',
    ]) +
    self.ExecAlways('"swaymsg -t subscribe \'[\\"shutdown\\"]\' && systemctl --user stop sway-session.target"') +
    OptionalNewline(newlineAfter),
  Gaps(inner, smart=true, newlineBefore=false, newlineAfter=true):
    OptionalNewline(newlineBefore) +
    self.Comment('gaps') +
    [
      'smart_gaps %(status)s' % { status: (if smart then 'on' else 'off') },
      'gaps inner %(value)s' % { value: inner },
    ] +
    OptionalNewline(newlineAfter),
  Font(name, size, newlineBefore=false, newlineAfter=true):
    OptionalNewline(newlineBefore) +
    self.Comment('font') +
    [
      'font pango:%(name)s %(size)s' % {
        name: name,
        size: size,
      },
    ] +
    OptionalNewline(newlineAfter),
  local IOSEVKA = 'Iosevka',
  FontIosevka(size): self.Font(IOSEVKA, size),
  local INTER = 'Inter',
  FontInter(size): self.Font(INTER, size),
  Borders(default=1,
          floating=1,
          hide_edge_borders='smart',
          newlineBefore=false,
          newlineAfter=true):
    OptionalNewline(newlineBefore) +
    self.Comment('borders') +
    [
      'default_border pixel %(value)s' % { value: default },
      'default_floating_border pixel %(value)s' % { value: floating },
    ] +
    Optional(['hide_edge_borders %(value)s' % { value: hide_edge_borders }], hide_edge_borders != null) +
    OptionalNewline(newlineAfter),
  Input(type,
        settings=null,
        newlineBefore=false,
        newlineAfter=true):
    OptionalNewline(newlineBefore) +
    self.Comment([
      type,
    ]) +
    [
      'input type:%(type)s {' % { type: type },
    ] +
    [
      '  %(name)s %(value)s' % {
        name: name,
        value: settings[name],
      }
      for name in std.objectFields(if settings != null then settings else {})
    ] +
    [
      '}',
    ] +
    OptionalNewline(newlineAfter),
  Touchpad(dwt='enabled',
           tap='enabled',
           natural_scroll='enabled',
           middle_emulation='enabled',
           newlineBefore=false,
           newlineAfter=true):
    self.Input('touchpad', {
      dwt: dwt,
      tap: tap,
      natural_scroll: natural_scroll,
      middle_emulation: middle_emulation,
    }, newlineBefore, newlineAfter),
}
