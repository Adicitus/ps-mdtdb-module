function New-MDTRole {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true)] $name,
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $settings
    )

    Process
    {
        # Insert a new role row and get the identity result
        $sql = "INSERT INTO RoleIdentity (Role) VALUES ('$name') SELECT @@IDENTITY"
        Write-Debug "About to execute command: $sql"
        $identityCmd = New-Object System.Data.SqlClient.SqlCommand($sql, $mdtSQLConnection)
        $identity = $identityCmd.ExecuteScalar()
        Write-Debug "Added role identity record"
    
        # Insert the settings row, adding the values as specified in the hash table
        $settingsColumns = $settings.Keys -join ","
        $settingsValues = $settings.Values -join "','"
        $sql = "INSERT INTO Settings (Type, ID, $settingsColumns) VALUES ('R', $identity, '$settingsValues')"
        Write-Debug "About to execute command: $sql"
        $settingsCmd = New-Object System.Data.SqlClient.SqlCommand($sql, $mdtSQLConnection)
        $null = $settingsCmd.ExecuteScalar()
            
        Write-Debug "Added settings for the specified role"
        
        # Write the new record back to the pipeline
        Get-MDTRole -ID $identity
    }
}