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
unit ts.Editor.CodeFormatters;

interface

uses
  System.Classes, System.SysUtils;

type
  // 1. CAMBIO: Definimos la Interfaz con el nombre correcto "ICodeFormatter"
  ICodeFormatter = interface
    ['{3FD89A57-D3C9-4B85-8BDF-9954C6D30C52}']
    function Format(const AString: string): string;
  end;

  // Función factoría global
  function GetSQLFormatter: ICodeFormatter;

implementation

// 2. Usamos la unidad SQL SOLO aquí en implementation para evitar referencia circular
uses
  ts.Editor.CodeFormatters.SQL;

function GetSQLFormatter: ICodeFormatter;
begin
  // 3. Creamos la instancia de la CLASE concreta que está en la otra unidad
  Result := ts.Editor.CodeFormatters.SQL.TSQLFormatter.Create;
end;

end.
