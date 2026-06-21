{
  Copyright (C) 2013-2023 Tim Sinaeve tim.sinaeve@gmail.com
  Copyright (C) 2026 Alejandro Laorden Hidalgo alejandro.laorden@proton.me

  Este archivo deriva originalmente de código de Tim Sinaeve, publicado bajo
  la Apache License, Version 2.0, y ha sido modificado de forma sustancial.

  DOBLE LICENCIA / DUAL LICENSE
  ---------------------------------------------------------------------------
  - El código original de Tim Sinaeve permanece bajo la Apache License,
    Version 2.0 (texto al final de esta cabecera).
  - Las modificaciones y nuevas aportaciones de Alejandro Laorden Hidalgo se
    publican bajo la MIT License (texto a continuación).

  MIT License (modificaciones de Alejandro Laorden Hidalgo):

      Permission is hereby granted, free of charge, to any person obtaining a
      copy of this software and associated documentation files (the
      "Software"), to deal in the Software without restriction, including
      without limitation the rights to use, copy, modify, merge, publish,
      distribute, sublicense, and/or sell copies of the Software, and to
      permit persons to whom the Software is furnished to do so, subject to
      the following conditions:

      The above copyright notice and this permission notice shall be included
      in all copies or substantial portions of the Software.

      THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
      OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
      MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
      IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
      CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
      TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
      SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

  Apache License, Version 2.0 (código original de Tim Sinaeve):

      Licensed under the Apache License, Version 2.0 (the "License");
      you may not use this file except in compliance with the License.
      You may obtain a copy of the License at

          http://www.apache.org/licenses/LICENSE-2.0

      Unless required by applicable law or agreed to in writing, software
      distributed under the License is distributed on an "AS IS" BASIS,
      WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
      See the License for the specific language governing permissions and
      limitations under the License.
}
unit ts.Editor.CodeFormatters.SQL;

interface

uses
  System.Classes, System.SysUtils,
  ts.Core.SQLParser,
  ts.Core.SQLScanner,
  ts.Core.SQLTree,
  ts.Editor.CodeFormatters; // Aquí está la interfaz ICodeFormatter

type
  TSQLFormatter = class(TInterfacedObject, ICodeFormatter)
  protected
    // Nota: Hemos quitado FLineReader, FSQLParser, etc. porque ahora
    // se crean localmente dentro de la función Format.
    function Format(const AString: string): string;
  end;

implementation

{ TSQLFormatter }

function TSQLFormatter.Format(const AString: string): string;
var
  SS : TStringStream;
  LR : TStreamLineReader;
  P  : TSQLParser;
  S  : TSQLScanner;
  E  : TSQLElement;
  FormattedSQL: string;
begin
  Result := AString;
  if Trim(AString) = '' then Exit;

  SS := TStringStream.Create(AString, TEncoding.UTF8);
  LR := TStreamLineReader.Create(SS);
  S  := TSQLScanner.Create(LR);
  P  := TSQLParser.Create(S);

  try
    try
      S.Options := [soBackslashEscapes, soBackQuoteIdentifier];
      FormattedSQL := '';

      // Bucle para parsear y formatear TODOS los comandos del script
      repeat
        E := P.Parse; // Leemos un comando

        if Assigned(E) then
        begin
          // Si ya hay comandos acumulados, le ponemos un punto y coma y salto de línea
          if FormattedSQL <> '' then
            FormattedSQL := FormattedSQL + ';' + sLineBreak + sLineBreak;

          // Acumulamos el comando formateado
          FormattedSQL := FormattedSQL + E.GetAsSQL([
            sfoLowercaseKeyword, sfoOneFieldPerLine, sfoIndentFields,
            sfoOneTablePerLine, sfoIndentTables, sfoWhereOnSeparateLine,
            sfoIndentWhere // (Pon aquí las opciones que usabas)
          ]);

          E.Free; // Importante: liberar la memoria del nodo que ya hemos usado
        end;
      until (E = nil); // Repetimos hasta que el parser no devuelva nada (fin del texto)

      // Si logramos formatear algo, le añadimos el punto y coma final
      if FormattedSQL <> '' then
        Result := FormattedSQL + ';';

    except
      on Ex: Exception do
      begin
        // Si CUALQUIER comando del bloque da error, devolvemos el texto original
        // intacto con el comentario de error arriba para no perder código.
        Result := '/* ERROR DEL PARSER: ' + Ex.Message + ' */' + sLineBreak + AString;
      end;
    end;
  finally
    P.Free;
    S.Free;
    LR.Free;
    SS.Free;
  end;
end;

end.
