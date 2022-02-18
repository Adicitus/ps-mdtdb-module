function Remove-MDTRole {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $id
    )

    Process
    {
        # Build the delete command
        $delCommand = "DELETE FROM RoleIdentity WHERE ID = $id"
        
        # Issue the delete command
        Write-Debug "About to issue command: $delCommand"
        $cmd = New-Object System.Data.SqlClient.SqlCommand($delCommand, $mdtSQLConnection)
        $null = $cmd.ExecuteScalar()

        Write-Debug "Removed the role with ID = $id."
    }
}