# parsersql4delphi
Formateador de MySQL para delphi nativo, incluye consultas, ddl, vistas y procedimientos almacenados
```pascal
//Ejemplo
function FormatearSQL(sSQL:string):string;
var
  Formatter: ICodeFormatter;
begin
  Formatter := GetSQLFormatter;
  Result := Formatter.Format(sSQL);
end;
```pascal
