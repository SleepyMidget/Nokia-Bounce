unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, Stage1;

type

  { TBounceForm }

  TBounceForm = class(TForm)
    ExitButton: TButton;
    Label1: TLabel;
    TutorialLabel: TLabel;
    MenuLabel: TLabel;
    PlayButton: TButton;
    MenuImage: TImage;
    TimerBounce: TTimer;
    procedure AboutButtonClick(Sender: TObject);
    procedure ExitButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuImageClick(Sender: TObject);
    procedure PlayButtonClick(Sender: TObject);
    procedure TimerBounceTimer(Sender: TObject);
  private
  public

  end;

var
BounceForm: TBounceForm;
y: Integer;
Gerak: integer;


implementation

{$R *.lfm}

{ TBounceForm }

procedure TBounceForm.MenuImageClick(Sender: TObject);
begin

end;

procedure TBounceForm.PlayButtonClick(Sender: TObject);
  var
  NewForm: TStage;
begin

  NewForm := TStage.Create(Self);
  try
    NewForm.ShowModal;
  finally
    NewForm.Free;
  end;
  Application.Terminate;
end;



procedure TBounceForm.TimerBounceTimer(Sender: TObject);

begin
  if y >= 120 then
    gerak :=-2;
  if y<=50 then
    gerak := 2;

  y := y+gerak;

  //hapus
  Menuimage.Canvas.Brush.Color := clWhite;
  Menuimage.Canvas.Pen.Color := clWhite;
  Menuimage.Canvas.Pen.Style := psSolid;
  Menuimage.Canvas.Rectangle(275,y-25+(gerak*(-1)),325,y+25+(gerak*(-1)));
  Menuimage.Canvas.Brush.Color := clRed;
  Menuimage.Canvas.Pen.Color := clRed;
  Menuimage.Canvas.Pen.Style := psSolid;
  Menuimage.Canvas.Ellipse(275,y-25,325,y+25);

end;

procedure TBounceForm.FormCreate(Sender: TObject);

var
  LabelWidth: Integer;

begin
  MenuLabel.Caption := 'Bounce'; // set the text of the label
  MenuLabel.Alignment := taCenter;
  MenuLabel.AutoSize := True;
  MenuLabel.Font.Size := 32; // increase the font size
  MenuLabel.Font.Style := [fsBold]; // make the font bold
  LabelWidth := MenuLabel.Canvas.TextWidth(MenuLabel.Caption);
  MenuLabel.Left := (ClientWidth - LabelWidth) div 2;

  bounceform.Position := poScreenCenter;

end;

procedure TBounceForm.ExitButtonClick(Sender: TObject);
begin
  close;
end;

procedure TBounceForm.AboutButtonClick(Sender: TObject);
begin

end;

procedure TBounceForm.FormShow(Sender: TObject);
begin
  y := 100;
  gerak := 3;
  Menuimage.Canvas.Pen.Color:=clWhite;
  Menuimage.Canvas.Brush.Color:=clWhite;
  Menuimage.Canvas.Rectangle(0,0,Menuimage.Width,Menuimage.Height);
end;

end.



