# parsersql4delphi
Formateador de MySQL para delphi nativo, incluye SELECT, UPDATE, INSERT, DELETE... DDL, VIEWS AND STORED PROCEDURES
```pascal
//Ejemplo
function FormatearSQL(sSQL:string):string;
var
  Formatter: ICodeFormatter;
begin
  Formatter := GetSQLFormatter;
  Result := Formatter.Format(sSQL);
end;

