package octane.types;


#if flash

#else
typedef NativeDisplayObject = pixi.core.display.DisplayObject;
typedef NativeContainer = pixi.core.display.Container;
typedef NativeSprite = pixi.core.sprites.Sprite;
typedef NativeMovieClip = pixi.extras.MovieClip;
typedef NativeSpine = pixi.plugins.spine.Spine;
typedef NativeTextField = pixi.core.text.Text;
typedef NativeStage = pixi.core.display.Container;
typedef NativeGraphics = pixi.core.graphics.Graphics;
typedef NativeTexture = pixi.core.textures.Texture;
typedef NativeTextureArray = Array<NativeTexture>;
typedef NativePoint = pixi.core.math.Point;
typedef NativeRectangle = pixi.core.math.shapes.Rectangle;
typedef NativeSound = WaudSound;
#end