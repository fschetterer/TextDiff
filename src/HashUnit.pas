unit HashUnit;

{$IFDEF FPC}
  {$mode delphi}{$H+}
{$ENDIF}

// -----------------------------------------------------------------------------
// Application:     TextDiff                                                   .
// Module:          HashUnit                                                   .
// Version:         5.0                                                        .
// Date:            18-MAY-2020                                                .
// Target:          Win32, Delphi 10.x                                         .
// Author:          Angus Johnson - angusj-AT-myrealbox-DOT-com                .
// Updates by:      Rickard Johansson (RJ TextEd)                              .
// Copyright;       © 2003-2004 Angus Johnson                                  .
// -----------------------------------------------------------------------------

(*******************************************************************************
* History:                                                                     *
* 18 May 2020                                                                  *
*   Added Lazarus support                                                      *
*   Updated comment section for public release of version 5.0                  *
*                                                                              *
* 11 November 2018                                                             *
* - Hashline returns a Cardinal instead of a pointer                           *
*   Updated Hashline (IgnoreBlanks) to handle Unicode white spaces             *
*   CalcCRC32 updated to handle Unicode string                                 *
*******************************************************************************)

interface

uses
  SysUtils;

function HashLine(const line: string; IgnoreCase, IgnoreBlanks: boolean): Cardinal;

implementation
{$REGION 'History'}
//  14-Feb-2021 - added Winapi.Windows and System.Character to allow compiling in 10.4.1
//              - replaced the need for yet another hash table by using FastCompare.MurmurHash3 which has the best non-collision results for strings under size 250
{$ENDREGION}

uses
  {$ifndef fpc}
  Winapi.Windows,
  System.Character,
  FastCompare;
  {$else}
  Character;
  {$endif}

function HashLine(const line: string; IgnoreCase, IgnoreBlanks: boolean): Cardinal;
var
  i,j,len: integer;
  s: string;
begin
  s := line;
  len := Length(line);
  if IgnoreBlanks then
  begin
    i := 1;
    j := 1;
    while i <= len do
    begin
      if not line[i].IsWhiteSpace then
      begin
        s[j] := line[i];
        inc(j);
      end;
      inc(i);
    end;
    len := j-1;
    setlength(s,len);
  end;
  if IgnoreCase then
    s := s.ToUpper;
  Result := FastCompare.MurmurHash3(PChar(s)^, Len * SizeOf(Char));
end;

end.
