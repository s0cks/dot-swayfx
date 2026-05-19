local sway = import 'lib/sway.libsonnet';

local FontSize = 9;
local BorderThickness = 2;
local SwayColors =
  [
    '# Colors                  border   bg     text      indi  childborder',
    'client.focused            $pu      $bg    $paper    $pu   $pu',
    'client.focused_inactive   $bg      $bg    $paper    $bg   $bg',
    'client.unfocused          $bg      $bg    $paper    $bg   $bg',
    'client.urgent             $re      $bg    $paper    $re   $re',
  ];
local SwayConfig =
  sway.IncludeUserConfig +
  sway.IncludeSystemConfig +
  [''] +
  SwayColors +
  [''] +
  sway.FontInter(FontSize) +
  sway.Borders(BorderThickness, BorderThickness) +
  // sway.Touchpad() +
  sway.Systemd(true);

{
  config:
    std.lines(std.flattenDeepArray(
      sway.Comment([
        'vim: filetype=swayconfig :',
        '*** Do NOT edit ***',
        'This file was auto-generated using Jsonnet',
        '  ~ @s0cks',
      ], newlineAfter=true) +
      SwayConfig
    )),
}
