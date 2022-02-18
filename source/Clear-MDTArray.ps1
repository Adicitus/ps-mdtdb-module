function Clear-MDTArray {

    PARAM
    (
        $id,
        $type,
        $table
    )

    # Build the delete command
    $delCommand = "DELETE FROM $table WHERE ID = $id and Type = '$type'"
        
    # Issue the delete command
    Write-Debug "About to issue command: $delCommand"
    $cmd = New-Object System.Data.SqlClient.SqlCommand($delCommand, $mdtSQLConnection)
    $null = $cmd.ExecuteScalar()

    Write-Debug "Removed all records from $table for Type = $type and ID = $id."
}