function Remove-MDTLocation {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $id
    )

    Process
    {
        # Build the delete command
        $delCommand = "DELETE FROM LocationIdentity WHERE ID = $id"
        
        # Issue the delete command
        Write-Verbose "About to issue command: $delCommand"
        $cmd = New-Object System.Data.SqlClient.SqlCommand($delCommand, $mdtSQLConnection)
        $null = $cmd.ExecuteScalar()

        Write-Host "Removed the location with ID = $id."
    }
}