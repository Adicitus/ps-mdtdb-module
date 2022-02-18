function Set-MDTArray {

    PARAM
    (
        $id,
        $type,
        $table,
        $column,
        $array
    )

    # First clear the existing array
    Clear-MDTArray $id $type $table
    
    # Now insert each row in the array
    $seq = 1
    foreach ($item in $array)
    {
        # Insert the  row
        $sql = "INSERT INTO $table (Type, ID, Sequence, $column) VALUES ('$type', $id, $seq, '$item')"
        Write-Debug "About to execute command: $sql"
        $settingsCmd = New-Object System.Data.SqlClient.SqlCommand($sql, $mdtSQLConnection)
        $null = $settingsCmd.ExecuteScalar()

        # Increment the counter
        $seq = $seq + 1
    }
        
    Write-Debug "Added records to $table for Type = $type and ID = $id."
}