{ lib, ... }:
with builtins;
with lib;
with rec {
  toFloat = int: fromJSON "${toString int}.0";
  floor = f: 
    let chars = stringToCharacters (toJSON f);
        searcher = n: c: 
          if n.found 
            then n 
            else if c == "." 
              then { index = n.index; found = true; } 
              else { index = n.index + 1; found = false; };
        radix = (foldl searcher { index = 0; found = false; } chars).index;
    in fromJSON (concatStrings (take radix chars));
  realMod = x: y: 
    let i = floor x;
        frac = x - i;
    in mod i y + frac;
  abs = x: if x < 0 then -x else x;
  round = f:
    let i = floor f;
        frac = abs f - i;
    in if frac < 0.5 then i else i + 1;
  clamp = f: max 0 (min f 1);
  hex-to-int = c: 
    let table =
        { "0" = 0; "1" = 1; "2" = 2; "3" = 3; "4" = 4; "5" = 5; "6" = 6; "7" = 7; "8" = 8; "9" = 9;
          "A" = 10; "B" = 11; "C" = 12; "D" = 13; "E" = 14; "F" = 15;
        };
    in table.${toUpper c}; 
  int-to-hex = i:
    let table = { "10" = "A"; "11" = "B"; "12" = "C"; "13" = "D"; "14" = "E"; "15" = "F"; };
    in if i < 10 then toString i else table.${toString i};
  hex-pair-to-int = a: b: hex-to-int a * 16 + hex-to-int b; 
  int-to-hex-pair = i: int-to-hex (div i 16) + int-to-hex (mod i 16);  
  rgb = str: 
    let chars = stringToCharacters str;
        hex-pair-at = n: hex-pair-to-int (elemAt chars n) (elemAt chars (n + 1));
    in
    if length chars == 6 then
      { red = hex-pair-at 0; green = hex-pair-at 2; blue = hex-pair-at 4; }
    else
      throw "no parse";
  hex = rgb: "#" + int-to-hex-pair rgb.red + int-to-hex-pair rgb.green + int-to-hex-pair rgb.blue;
  rgb-to-hsv = rgb:
    let norm-r = toFloat rgb.red / 255;
        norm-g = toFloat rgb.green / 255;
        norm-b = toFloat rgb.blue / 255; 
        max-comp = max (max norm-r norm-g) norm-b;
        min-comp = min (min norm-r norm-g) norm-b;
        value = max-comp;
        chroma = max-comp - min-comp;
        saturation = if value == 0 then 0 else chroma / value;
        hue = if chroma == 0
          then 0
          else if value == norm-r
            then 60 * (0 + (norm-g - norm-b) / chroma)
            else if value == norm-g
              then 60 * (2 + (norm-b - norm-r) / chroma)
              else if value == norm-b
                then 60 * (4 + (norm-r - norm-g) / chroma)
                else throw "impossible";
    in { inherit hue saturation value; };
  hsv-to-rgb = hsv: with hsv;
    let cylinder = n: 
          let k = realMod (n + hue / 60) 6;
          in
          value - value * saturation * clamp (min k (4 - k));
        red = round (cylinder 5 * 255);
        green = round (cylinder 3 * 255);
        blue = round (cylinder 1 * 255);  
    in { inherit red green blue; };
  raise-value = p: hsv: 
    { value = clamp ((1 + p) * hsv.value); inherit (hsv) hue saturation; };
  brighten = rgb: hsv-to-rgb (raise-value 0.2 (rgb-to-hsv rgb));
  darken = rgb: hsv-to-rgb (raise-value (- 0.2) (rgb-to-hsv rgb));
};
rec { 
  rich-black = rgb "060A16";
  middle-green = rgb "5F9057";
  harvest-gold = rgb "D49221";
  cadet-grey = rgb "97AEBE";
  bittersweet-shimmer = rgb "B85653";
  dark-liver = rgb "45454B";
  malachite = rgb "1ED761";

  black = rgb "000000";
  red = bittersweet-shimmer;
  green = middle-green;

  primary = harvest-gold;
  primary-light = brighten primary;
  primary-dark = darken primary;
  secondary = middle-green;
  secondary-light = brighten secondary;
  secondary-dark = darken secondary;
  accent = bittersweet-shimmer;
  accent-light = brighten accent;
  accent-dark = darken accent;
  dark = rich-black;
  dark-light = brighten dark;
  dark-dark = darken dark;
  light = cadet-grey;
  light-light = brighten light;
  light-dark = darken dark;
  inherit hex brighten darken rgb-to-hsv hsv-to-rgb;
}
