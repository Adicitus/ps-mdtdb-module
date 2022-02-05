function Get-MDTArray {

    PARAM
    (
        $id,
        $type,
        $table,
        $column
    )

    # Build the select command
    $sql = "SELECT $column FROM $table WHERE ID = $id AND Type = '$type' ORDER BY Sequence"
        
    # Issue the select command and return the results
    Write-Verbose "About to issue command: $sql"
    $selectAdapter = New-Object System.Data.SqlClient.SqlDataAdapter($sql, $mdtSQLConnection)
    $selectDataset = New-Object System.Data.Dataset
    $null = $selectAdapter.Fill($selectDataset, "$table")
    $selectDataset.Tables[0].Rows 
}