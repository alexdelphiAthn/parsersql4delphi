# parsersql4delphi
Parser de MySQL para delphi nativo
``pascal
//Ejemplo
function FormatearSQL(sSQL:string):string;
var
  Formatter: ICodeFormatter;
begin
  Formatter := GetSQLFormatter;
  Result := Formatter.Format(sSQL);
end;
``pascal
