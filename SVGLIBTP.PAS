{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2023
  @website(https://www.gladir.com/CODER/SVGLIB-TP)
  @abstract(Target: Turbo Pascal 7, Free Pascal 3.2)
}

Unit SVGLIBTP;

INTERFACE

Type
 PointType=Record
  X,Y:Word;
 End;

 ArrayPoint=Array[0..100] of PointType;

Procedure CircleSVG(Var F:Text;X,Y,R:Integer);
Function  CloseSVG(Var F:Text):Boolean;
Function  CreateSVG(Var F:Text;FileName:String):Boolean;
Function  CreateWithSizeSVG(Var F:Text;FileName:String;Width,Height:Word):Boolean;
Procedure FillPolySVG(Var F:Text;N:Integer;Var P:ArrayPoint);
Procedure LineSVG(Var F:Text;X1,Y1,X2,Y2:Integer);
Procedure RectSVG(Var F:Text;X1,Y1,X2,Y2:Integer);
Procedure WriteTextSVG(Var F:Text;Msg:String);
Procedure WriteTextXY_SVG(Var F:Text;X,Y:Integer;Msg:String);

IMPLEMENTATION

Function CreateWithSizeSVG(Var F:Text;FileName:String;Width,Height:Word):Boolean;Begin
 {$I-}Assign(F,FileName);
 Rewrite(F);{$I+}
 If(IOResult=0)Then Begin
  WriteLn(F,'<svg width="',Width,'" height="',Height,'" xmlns="http://www.w3.org/2000/svg">');
  CreateWithSizeSVG:=True;
 End
  Else
 CreateWithSizeSVG:=False;
End;

Function CreateSVG(Var F:Text;FileName:String):Boolean;Begin
 CreateSVG:=CreateWithSizeSVG(F,FileName,640,480);
End;

Procedure CircleSVG(Var F:Text;X,Y,R:Integer);Begin
 Write(F,'<circle cx="',X,'" ','cy="',Y,'" r="',R,'"/>');
End;

Procedure LineSVG(Var F:Text;X1,Y1,X2,Y2:Integer);Begin
 Write(F,'<line x1="',X1,'" ','y1="',Y1,'" ',
               'x2="',X2,'" ','y2="',Y2,'"/>');
End;

Procedure FillPolySVG(Var F:Text;N:Integer;Var P:ArrayPoint);
Var
 I:Integer;
Begin
 Write(F,'<polyline stroke="black" stroke-width="1" fill="none" points="');
 For I:=1 to N do Begin
  Write(F,P[I].X,' ',P[I].Y,' ');
 End;
End;

Procedure RectSVG(Var F:Text;X1,Y1,X2,Y2:Integer);Begin
 Write(F,'<rect x="',X1,'" ','y="',Y1,'" ',
               'width="',(X2-X1)+1,'" ','height="',(Y2-Y1)+1,'"/>');
End;

Procedure WriteTextSVG(Var F:Text;Msg:String);Begin
 Write(F,'<text>');
 Write(F,Msg);
 WriteLn(F,'</text>');
End;

Procedure WriteTextXY_SVG(Var F:Text;X,Y:Integer;Msg:String);Begin
 Write(F,'<text x="',X,'" y="',Y,'">');
 Write(F,Msg);
 WriteLn(F,'</text>');
End;

Function CloseSVG(Var F:Text):Boolean;Begin
 WriteLn(F,'</svg>');
 Close(F);
 CloseSVG:=IOResult=0;
End;

END.
