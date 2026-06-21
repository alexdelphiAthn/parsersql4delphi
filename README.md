# parsersql4delphi

Formateador de SQL **MySQL/MariaDB** para Delphi nativo. Incluye SELECT,
UPDATE, INSERT, DELETE, DDL (CREATE/ALTER/DROP), VIEWS y STORED PROCEDURES.

```pascal
//Ejemplo
function FormatearSQL(sSQL:string):string;
var
  Formatter: ICodeFormatter;
begin
  Formatter := GetSQLFormatter;
  Result := Formatter.Format(sSQL);
end;
```

## Sentencias soportadas

- **DML:** `SELECT` (CTE `WITH`, `UNION`, JOINs, subconsultas, `GROUP BY`,
  `HAVING`, `ORDER BY`, `LIMIT`), `INSERT` (incluye `REPLACE` e
  `INSERT IGNORE`), `UPDATE`, `DELETE`.
- **DDL** (`CREATE` / `ALTER` / `DROP`): `TABLE` (`AUTO_INCREMENT`,
  `DEFAULT`, `NOT NULL`, `COMMENT`, constraints, claves foráneas), `VIEW`
  (`CREATE OR REPLACE`, `ALGORITHM` / `DEFINER` / `SQL SECURITY`),
  `PROCEDURE`, `TRIGGER`, `INDEX`, `DATABASE` / `SCHEMA`, `DOMAIN`,
  `EXCEPTION`, `GENERATOR`, `ROLE`, `SHADOW`.
- **Transacciones / sesión:** `SET`, `COMMIT`, `ROLLBACK`,
  `START TRANSACTION`, `CONNECT`.
- **Otros:** `DECLARE`, `EXECUTE PROCEDURE`,
  `PREPARE` / `EXECUTE` / `DEALLOCATE`, `GRANT` / `REVOKE` y bloques
  `DELIMITER ... $$`.

## Licencia

Este proyecto tiene **licencia doble**:

- El código original de **Tim Sinaeve** se distribuye bajo la **Apache
  License, Version 2.0** (ver [`LICENSE`](LICENSE)).
- Las modificaciones y nuevas aportaciones de **Alejandro Laorden Hidalgo**
  se distribuyen bajo la **MIT License** (ver [`LICENSE-MIT`](LICENSE-MIT)).

Cada fichero fuente incluye ambas licencias en su cabecera.
