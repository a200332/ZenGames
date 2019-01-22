program Game;

{$INCLUDE 'ZenGames/Engines/MondoZenGL/mz_config.cfg'}

uses
  zglHeader,
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
    timer     : TMZTimer;
    texLogo   : TMZTexture;

    procedure TimerExpired(Sender: TObject);
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
end;




procedure TGameScene.TimerExpired(Sender: TObject);
begin
  Application.Caption := TMZUtils.Format(TITLE + ' [%d FPS]', [Application.CurrentRenderFrameRate]);

  if TMZKeyboard.IsKeyPressed(kcEscape) then
    Application.Quit;

  TMZKeyboard.ClearState;
end;


procedure TGameScene.Startup;
begin
  inherited Startup;
  timer   := TMZTimer.Create(TimerExpired, 1000);

{$IFDEF PACKBIN}
  { Load the image/audio/video/etc from itself }
  TMZZipArchive.OpenArchive('game');
{$ENDIF}

  texLogo := TMZTexture.Create(RESOURCE_DIR + 'mondozengl.png');

{$IFDEF PACKBIN}
{ Close at some point, when you no longer need it. }
  TMZZipArchive.CloseArchive;
{$ENDIF}
end;

procedure TGameScene.Shutdown;
begin
  texLogo.Free;
  timer.Free;
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
{$IFNDEF DEBUG}
  Application.Options := Application.Options + [aoShowCursor] - [aoEnableLogging];
{$ELSE}
  Application.Options := Application.Options + [aoShowCursor];
{$ENDIF}
  Application.Caption       := TITLE;
  Application.ScreenWidth   := SCRW;
  Application.ScreenHeight  := SCRH;

  Application.SetScene(TGameScene.Create);
  { The application and scene will automatically be freed on shutdown }
end.

{vim: set ts=2 sw=2 tw=500 et :}
