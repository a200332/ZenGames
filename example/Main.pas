program Game;

{$INCLUDE 'ZenGames/Engines/MondoZenGL/mz_config.cfg'}

uses
  zglHeader,

  zgl_sound_openal,
  MondoZenGL;

const
  RESOURCE_DIR  = 'data/';
  TITLE         = 'ZenGames';
  SCRW          = 1000;
  SCRH          = 710;

var
  Application: TMZApplication;

type TGameScene = class(TMZScene)
private
    texLogo   : TMZTexture;
    sndWave   : TMZStaticSound;

protected
    { Summary:
        Is called before the scene is executed. You can override this method
        to initialize scene specific resources. }
    procedure Startup; override;

    { Summary:
        Is called just before the scene is terminated. You can override this
        method to cleanup scene specific resources. }
    procedure Shutdown; override;

    { Summary:
        Is called during each iteration of the main loop to render the current
        frame. }
    procedure RenderFrame; override;

    procedure Update(const DeltaTimeMs: Double); override;

end;

function CalcX2D(const X: Single): Single;
begin
  Result := (X - SCRW / 2)  * (1 / SCRW / 2);
end;

function CalcY2D(const Y:Single): Single;
begin
  Result := (Y - SCRH / 2) * (1 / SCRH / 2);
end;


procedure TGameScene.Update(const DeltaTimeMs: Double);
begin
  inherited Update(DeltaTimeMs);

  Application.Caption := TMZUtils.Format(TITLE + ' [%d FPS]', [Application.CurrentRenderFrameRate]);

  if TMZKeyboard.IsKeyPressed(kcEscape) then
    Application.Quit;

  if TMZMouse.IsButtonDown(mbLeft) then
        sndWave.Play(False, CalcX2D(TMZMouse.X), CalcY2D(TMZMouse.Y));

  TMZKeyboard.ClearState;
  TMZMouse.ClearState;
end;


procedure TGameScene.Startup;
begin
  inherited Startup;

{$IFDEF PACKBIN}
  { Load the image/audio/video/etc from itself }
  TMZZipArchive.OpenArchive('game');
{$ENDIF}

  texLogo := TMZTexture.Create(RESOURCE_DIR + 'mondozengl.png');
  sndWave := TMZStaticSound.Create(1, ALUT_WAVEFORM_SQUARE, 440.0, 0.0, 0.3);

{$IFDEF PACKBIN}
{ Close at some point, when you no longer need it. }
  TMZZipArchive.CloseArchive;
{$ENDIF}
end;

procedure TGameScene.Shutdown;
begin
  texLogo.Free;
  sndWave.Free;
  inherited Shutdown;
end;


procedure TGameScene.RenderFrame;
begin
  inherited RenderFrame;
  Canvas.BeginBatch;
  Canvas.DrawSprite(texLogo, 0, 0, SCRW, SCRH);
  Canvas.EndBatch;
end;


begin
  Application := TMZApplication.Create;
  Application.Options := [aoShowCursor, aoUseSound];
{$IFNDEF DEBUG}
  Application.Options := Application.Options - [aoEnableLogging];
{$ENDIF}
  Application.Caption       := TITLE;
  Application.ScreenWidth   := SCRW;
  Application.ScreenHeight  := SCRH;

  Application.SetScene(TGameScene.Create);
  { The application and scene will automatically be freed on shutdown }
end.

{vim: set ts=2 sw=2 tw=500 et :}
