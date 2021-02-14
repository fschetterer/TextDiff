// JCL_DEBUG_EXPERT_GENERATEJDBG OFF
program BasicDiffDemo2;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

{$REGION 'History'}
//  14-Feb-2021 - added HashUnit to compile
{$ENDREGION}
uses
  {$IFnDEF FPC}
  {$ELSE}
  Interfaces,
  {$ENDIF }
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Diff in '..\src\Diff.pas',
  HashUnit in '..\src\HashUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
