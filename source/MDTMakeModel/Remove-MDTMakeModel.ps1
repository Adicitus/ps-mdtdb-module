function Remove-MDTMakeModel {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $id
    )

    Process
    {
        # Build the delete command
        $delCommand = "DELETE FROM MakeModelIdentity WHERE ID = $id"
        
        # Issue the delete command
        Write-Verbose "About to issue command: $delCommand"
        $cmd = New-Object System.Data.SqlClient.SqlCommand($delCommand, $mdtSQLConnection)
        $null = $cmd.ExecuteScalar()

        Write-Host "Removed the make model with ID = $id."
    }
}