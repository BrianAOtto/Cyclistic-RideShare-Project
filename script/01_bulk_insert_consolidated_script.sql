/* =====================================================================
   Cyclistic / Divvy Trip Data — Consolidated Import Script
   ---------------------------------------------------------------------
   Purpose: This script documents the approach for loading all 12
   monthly CSV files directly into a single divvy_tripdata_consolidated
   table in SQL Server.

   Scope: 12 months of Divvy trip data, April 2025 – March 2026.
   Naming convention below follows Divvy's standard file naming
   (YYYYMM-divvy-tripdata.csv).

   NOTE: This script assumes divvy_tripdata_consolidated already
   exists (created in a separate DDL step, not shown here) with a
   schema matching the source CSV columns.

   NOTE: BULK INSERT's FROM clause requires a literal string, so a
   plain @path + filename expression is not valid there. This script
   uses dynamic SQL (sp_executesql) so the @path variable can still
   be reused across all 12 files from a single declaration.

   NOTE: Update @path below (folder only, no filename) to match your
   local file location.

   NOTE: ROWTERMINATOR is set to 0x0a (line feed only) rather than a
   literal '\n', since Windows-generated CSVs typically end lines in
   \r\n. Using '\n' alone leaves a trailing \r on the last column of
   every row, which silently corrupts that column's values on import.

   NOTE: Each file is loaded inside a TRY/CATCH block so that a
   missing, locked, or malformed file is reported by name instead of
   failing silently or halting the whole batch without explanation.

   NOTE: Many fields in the source CSVs carry leading/trailing quotation
   marks (e.g. "docked_bike"). BULK INSERT does not parse or strip CSV
   quoting, so these quotes are imported as literal characters into
   divvy_tripdata_consolidated. This is intentional — the consolidated
   table is meant to preserve the raw source data as-is. Quote removal
   is handled downstream in the data cleaning script when populating
   divvy_tripdata_cleaned.

   NOTE: The table is truncated before the load loop so this script
   can be safely rerun (e.g. after fixing a failed file) without
   duplicating rows from files that already loaded successfully.
   ===================================================================== */

DECLARE @path NVARCHAR(500) = 'C:\Data\';
DECLARE @sql NVARCHAR(MAX);
DECLARE @file NVARCHAR(100);

TRUNCATE TABLE divvy_tripdata_consolidated;

DECLARE @files TABLE (file_name NVARCHAR(100));
INSERT INTO @files (file_name) VALUES
    ('202504-divvy-tripdata.csv'),
    ('202505-divvy-tripdata.csv'),
    ('202506-divvy-tripdata.csv'),
    ('202507-divvy-tripdata.csv'),
    ('202508-divvy-tripdata.csv'),
    ('202509-divvy-tripdata.csv'),
    ('202510-divvy-tripdata.csv'),
    ('202511-divvy-tripdata.csv'),
    ('202512-divvy-tripdata.csv'),
    ('202601-divvy-tripdata.csv'),
    ('202602-divvy-tripdata.csv'),
    ('202603-divvy-tripdata.csv');

DECLARE file_cursor CURSOR FOR SELECT file_name FROM @files;
OPEN file_cursor;
FETCH NEXT FROM file_cursor INTO @file;

WHILE @@FETCH_STATUS = 0
BEGIN
    BEGIN TRY
        SET @sql = 'BULK INSERT divvy_tripdata_consolidated FROM ''' + @path + @file + '''
            WITH (
                FIRSTROW = 2,
                FIELDTERMINATOR = '','',
                ROWTERMINATOR = ''0x0a'',
                CODEPAGE = ''65001'',
                TABLOCK
            );';
        EXEC sp_executesql @sql;
        PRINT 'Loaded: ' + @file;
    END TRY
    BEGIN CATCH
        PRINT 'FAILED: ' + @file + ' — ' + ERROR_MESSAGE();
    END CATCH

    FETCH NEXT FROM file_cursor INTO @file;
END

CLOSE file_cursor;
DEALLOCATE file_cursor;

/* ---------------------------------------------------------------------
   Verify row count after import
   --------------------------------------------------------------------- */
SELECT COUNT(*) AS total_rows_imported
FROM divvy_tripdata_consolidated;
