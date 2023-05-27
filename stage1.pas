unit stage1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Windows;

type

  { TStage }

  TStage = class(TForm)
    Ball: TShape;
    FlagFinish: TShape;
    Label1: TLabel;
    GameOverLabel: TLabel;
    Platform18: TShape;
    Platform19: TShape;
    Platform13: TShape;
    Platform12: TShape;
    Platform15: TShape;
    Platform16: TShape;
    Platform17: TShape;
    Platform14: TShape;
    PoleFinish: TShape;
    RetryLabel: TLabel;
    Platform9: TShape;
    Platform10: TShape;
    Platform11: TShape;
    Platform8: TShape;
    spike10: TShape;
    spike11: TShape;
    spike12: TShape;
    spike13: TShape;
    Spike14: TShape;
    Spike15: TShape;
    Spike16: TShape;
    Spike17: TShape;
    Spike18: TShape;
    Spike19: TShape;
    Spike20: TShape;
    Spike21: TShape;
    Spike22: TShape;
    Spike23: TShape;
    Spike24: TShape;
    Spike25: TShape;
    spike26: TShape;
    spike27: TShape;
    spike28: TShape;
    spike29: TShape;
    spike30: TShape;
    spike31: TShape;
    spike32: TShape;
    spike33: TShape;
    spike6: TShape;
    spike7: TShape;
    spike8: TShape;
    spike5: TShape;
    Platform2: TShape;
    platform1: TShape;
    Platform3: TShape;
    Platform4: TShape;
    Platform5: TShape;
    Platform6: TShape;
    Platform7: TShape;
    Spike1: TShape;
    Spike2: TShape;
    Spike3: TShape;
    Spike4: TShape;
    spike9: TShape;
    Timer1: TTimer;
    WinLabel: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GameOverLabelClick(Sender: TObject);
    procedure Platform12ChangeBounds(Sender: TObject);
    procedure Platform7ChangeBounds(Sender: TObject);
    procedure RetryLabelClick(Sender: TObject);
    procedure RetryLabelMouseEnter(Sender: TObject);
    procedure RetryLabelMouseLeave(Sender: TObject);
    procedure spike12ChangeBounds(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    SpeedX, SpeedY, temp : Integer;
    CanJump: Boolean;
    BallInitialLeft, BallInitialTop, Lives : integer;
    procedure GameOver;
    procedure Retry;
    procedure Win;
  public

  end;

var
  Stage: TStage;
  Platform: array [1..19] of TShape;
  //Plat: array[1..16] of Tshape;
  spike: array[1..33] of Tshape;

  x: Integer;

implementation

{$R *.lfm}

const
  Margin = 0.5;

{ TStage }

procedure TStage.Timer1Timer(Sender: TObject);
begin

    if(lives >= 0) then
    label1.caption := 'Lives : ' + inttostr(Lives) + ' Left'
    else
    label1.caption := 'Lives : 0 Left';

    Ball.Left := Ball.Left + SpeedX;
    Ball.Top := Ball.Top + SpeedY;

    if Ball.Top + Ball.Height < Stage.ClientHeight then
    SpeedY := SpeedY + 1;

   
  //for x := 1 to 16 do
  //begin
  //if (Ball.Left + Ball.Width >= Plat[x].Left + Margin ) and
  //   (Ball.Left <= Plat[x].Left + Plat[x].Width - Margin) and
  //   (Ball.Top + Ball.Height >= Plat[x].Top + Margin) and
  //   (Ball.Top <= Plat[x].Top + Plat[x].Height - Margin) then
  //begin
  //     // Deteksi collision pada sisi atas
  //  if (Ball.Top + Ball.Height <= Plat[x].Top + Margin + 20) and (SpeedY > 0) then
  //  begin
  //    Ball.Top := Plat[x].Top - Ball.Height;
  //    SpeedY := 0;
  //    CanJump := True;
  //  end;
  //end;
  //end;


  for x := 1 to 19 do
  begin
  if (Ball.Left + Ball.Width >= Platform[x].Left + Margin ) and
     (Ball.Left <= Platform[x].Left + Platform[x].Width - Margin) and
     (Ball.Top + Ball.Height >= Platform[x].Top + Margin) and
     (Ball.Top <= Platform[x].Top + Platform[x].Height - Margin) then
  begin
    // Deteksi collision pada sisi kiri
    if (Ball.Left + Ball.Width <= Platform[x].Left + Margin + 20) and (SpeedX > 0) then
    begin
      Ball.Left := Platform[x].Left - Ball.Width;
      SpeedX := 0;
    end;

    // Deteksi collision pada sisi kanan
    if (Ball.Left >= Platform[x].Left + Platform[x].Width - Margin - 20) and (SpeedX < 0) then
    begin
      Ball.Left := Platform[x].Left + Platform[x].Width;
      SpeedX := 0;
    end;

    // Deteksi collision pada sisi atas
    if (Ball.Top + Ball.Height <= Platform[x].Top + Margin + 20) and (SpeedY > 0) then
    begin
      Ball.Top := Platform[x].Top - Ball.Height;
      SpeedY := 0;
      CanJump := True;
    end;
  end;
  end;

  for x := 1 to 33 do
  begin
   if (Ball.Left + Ball.Width >= spike[x].Left + Margin) and
     (Ball.Left <= spike[x].Left + Spike[x].Width - Margin) and
     (Ball.Top + Ball.Height >= spike[x].Top + Margin) and
     (Ball.Top <= spike[x].Top + spike[x].Height - Margin) then
     begin
     lives -= 1;
     Ball.Left := BallInitialLeft; // Mengatur posisi bola kembali ke koordinat awal
     Ball.Top := BallInitialTop;
     SpeedX := 0;
     SpeedY := 0;
     end;
  end;

  if(lives < 0) then GameOver;

    if (Ball.Left + Ball.Width >= PoleFinish.Left + Margin) and
     (Ball.Left <= PoleFinish.Left + PoleFinish.Width - Margin) and
     (Ball.Top + Ball.Height >= PoleFinish.Top + Margin) and
     (Ball.Top <= PoleFinish.Top + PoleFinish.Height - Margin) then Win;


    if Ball.Left < 0 then
    begin
      Ball.Left := 0;
      SpeedX := 0;
    end;

    if Ball.Left + Ball.Width > Stage.ClientWidth then
    begin
      Ball.Left := Stage.ClientWidth - Ball.Width;
      SpeedX := 0;
    end;

    if Ball.Top < 0 then
    begin
      Ball.Top := 0;
      SpeedY := 0;
    end;

     if Ball.Top + Ball.Height > Stage.ClientHeight then
     begin
       Ball.Top := Stage.ClientHeight - Ball.Height;
       SpeedY := 0;
       CanJump := True;
     end;
  end;

procedure TStage.GameOver;
begin
  Timer1.Enabled:=false;

  GameOverLabel.Visible:=true;
  RetryLabel.Visible:=true;

end;

procedure TStage.Retry;
begin
  Timer1.Enabled:=true;
    Lives := 3;
    Ball.Left := BallInitialLeft; // Mengatur posisi bola kembali ke koordinat awal
    Ball.Top := BallInitialTop;
    SpeedX := 0;
    SpeedY := 0;
    GameOverLabel.Visible:=false;
  RetryLabel.Visible:=false;
  WinLabel.Visible:=false;
  FlagFinish.Brush.Color:=clWhite;

end;

procedure TStage.Win;
begin
    Timer1.Enabled:=false;

  WinLabel.Visible:=true;
  RetryLabel.Visible:=true;
  FlagFinish.Brush.Color:=clLime;
end;

procedure TStage.FormCreate(Sender: TObject);
begin
    SpeedX := 0;
    SpeedY := 0;
    lives :=3;

    Platform[1] := Platform1;
    Platform[2] := Platform2;
    Platform[3] := Platform3;
    Platform[4] := platform4;
    Platform[5] := Platform5;
    Platform[6] := Platform6;
    Platform[7] := Platform7;
    Platform[8] := Platform8;
    Platform[9] := Platform9;
    Platform[10] := Platform10;
    Platform[11] := Platform11;
    Platform[12] := Platform12;
    Platform[13] := Platform13;
    Platform[14] := Platform14;
    Platform[15] := Platform15;
    Platform[16] := Platform16;
    Platform[17] := Platform17;
    Platform[18] := Platform18;
    Platform[19] := Platform19;


    spike[1] := spike1;
    spike[2] := spike2;
    spike[3] := spike3;
    spike[4] := spike4;
    spike[5] := spike5;
    spike[6] := spike6;
    spike[7] := spike7;
    spike[8] := spike8;
    spike[9] := spike9;
    spike[10] := spike10;
    spike[11] := spike11;
    spike[12] := spike12;
    spike[13] := spike13;
    spike[14] := spike14;
    spike[15] := spike15;
    spike[16] := spike16;
    spike[17] := spike17;
    spike[18] := spike18;
    spike[19] := spike19;
    spike[20] := spike20;
    spike[21] := spike21;
    spike[22] := spike22;
    spike[23] := spike23;
    spike[24] := spike24;
    spike[25] := spike25;
    spike[26] := spike26;
    spike[27] := spike27;
    spike[28] := spike28;
    spike[29] := spike29;
    spike[30] := spike30;
    spike[31] := spike31;
    spike[32] := spike32;
    spike[33] := spike33;

   BallInitialLeft := Ball.left;
   BallInitialTop := Ball.top;

  Stage.BorderStyle := bsNone;
  Stage.Top := 0;
  Stage.Left := 0;
  Stage.Width := 1366;
  Stage.Height := 705;
  Stage.Position := poScreenCenter;


    CanJump := True;
end;

procedure TStage.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );

begin
  case Key of
  VK_A:
    begin
    SpeedX := -5;
  end;

  vk_w:
    begin
      if CanJump then
       begin
         SpeedY := -13;  // Adjust the jump height as needed
         CanJump := False;
       end;
    end;

  VK_D:
    begin
    SpeedX := 5;
    end;

  VK_SPACE:
  begin
   if CanJump then
    begin
      SpeedY := -13;  // Adjust the jump height as needed
      CanJump := False;
    end;
    end;
end;

end;

procedure TStage.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
  VK_A:
    begin
    SpeedX := 0;
  end;

  VK_D:
    begin
    SpeedX := 0;
    end;

  end;
end;

procedure TStage.GameOverLabelClick(Sender: TObject);
begin

end;

procedure TStage.Platform12ChangeBounds(Sender: TObject);
begin

end;

procedure TStage.Platform7ChangeBounds(Sender: TObject);
begin

end;

procedure TStage.RetryLabelClick(Sender: TObject);
begin
  Retry;

end;

procedure TStage.RetryLabelMouseEnter(Sender: TObject);
begin
  RetryLabel.Font.Style:=[fsBold];
end;

procedure TStage.RetryLabelMouseLeave(Sender: TObject);
begin
  RetryLabel.Font.Style:=[];
end;

procedure TStage.spike12ChangeBounds(Sender: TObject);
begin

end;



end.

