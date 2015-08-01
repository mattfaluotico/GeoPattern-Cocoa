# GeoPatternCocoa

Create beautiful patterns using native CoreGraphics.

This is a port of Jason Long's [GeoPattern](https://github.com/jasonlong/geo_pattern), originally written in Ruby to use SVGs. As SVGs require external support in Cocoa projects, this version uses CoreGraphics. GeoPattern just creates a sexy view. Since it's just a UIView, it can be used nearly anywhere.

![one](https://github.com/MattFaluotico/GeoPattern-Cocoa/blob/master/screens/one.png)

![two](https://github.com/MattFaluotico/GeoPattern-Cocoa/blob/master/screens/two.png)

![three](https://github.com/MattFaluotico/GeoPattern-Cocoa/blob/master/screens/three.png)


## Installing

Using Cocoapods.

`pod 'GeoPattern', ~> 1.0.3`

Otherwise, copy the GeoPattern folder into your project and include the Security framework in your project build.

## Using

You simply need to import `GeoPattern.h` and you're good to go.

You can create a GeoPatternView using storyboard or by initializing a new one. There are really only two methods.

To simply generate a pattern based off of a string:

`generateWithString: (NSString *) string`

to generate a pattern based on a string using preset options.

`generateWithString: (NSString *) string andOptions: (NSDictionary*) options`

## Options

- `kGeoPatternColor`: UIColor, the exact background color
- `kGeoPatternBaseColor` : UIColor to be edited by the algorithm. Hue and saturation are modified based on the input stirng.
- `kGeoPatternType` - the type of pattern of you want to use. (see list below)

## Pattern Types

This includes all of the patterns from the original project. Each pattern is accessed with an enum. To generate a GeoPatternView using a specific type of pattern, just add the key to the options parameter.

```objective-c

GeoPatternView *view = [[GeoPatternView alloc] initWithFrame....];

NSDictionary * options = @{
      kGeoPatternType: [NSNumber numberWithInteger: GeoPatternXes,
      kGeoPatternColor: [UIColor redColor]
    };

[view generateFromString: @"Matthew" withOptions: options;]

```

- Octogons => `GeoPatternOctogons`
- Overlappingcircles => `GeoPatternOverlappingcircles`
- Plussigns => `GeoPatternPlussigns`
- Xes => `GeoPatternXes`
- Sinewaves => `GeoPatternSinewaves`
- Hexagons => `GeoPatternHexagons`
- Overlappingrings => `GeoPatternOverlappingrings`
- Plaid => `GeoPatternPlaid`
- Triangles => `GeoPatternTriangles`
- Squares => `GeoPatternSquares`
- Concentriccircles => `GeoPatternConcentriccircles`
- Diamonds => `GeoPatternDiamonds`
- Tessellation => `GeoPatternTessellation`
- Nestedsquares => `GeoPatternNestedsquares`
- Mosaicsquares => `GeoPatternMosaicsquares`
- Chevrons => `GeoPatternChevrons`
