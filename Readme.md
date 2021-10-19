# SkiaD

SkiaD is a cross-platform 2D graphics API for `D` based on Mono's SkiaSharp. It provides a comprehensive 2D API that can be used across mobile, server and desktop models to render images.

### Require

- DMD 2.096.0 and above
- SkiaSharp 2.80.2 and above

### Setup

#### Download SkiaSharp 2.80.2

Download the SkiaSharp package from [here](https://www.nuget.org/api/v2/package/SkiaSharp/2.80.2). Extract the runtimes for your OS plantform.

#### Windows

```shell
> mkdir -p c:\lib\win-x64
> copy skiasharp\2.80.2\runtimes\win-x64\native\libSkiaSharp.dll c:\lib\win-x64
> cd lib\windows
> lib /def:skia.def /MACHINE:X64 /out:SkiaSharp.lib
> copy SkiaSharp.lib c:\lib\win-x64
```

#### OSX
```sh
> cp skiasharp/2.80.2/runtimes/osx/native/libSkiaSharp.dylib /usr/local/lib
```

### TODO

- [x] Improvements for SKColor parser
- [x] SKCanvas.DrawText with Chinese
- [ ] More tests


### See also

- https://github.com/mono/SkiaSharp
- https://www.nuget.org/packages/SkiaSharp
- https://github.com/mono/SkiaSharp/wiki/Building-SkiaSharp
- https://stackoverflow.com/questions/59214555/how-to-build-skiasharp-project-the-libskiasharp-dll-is-missing