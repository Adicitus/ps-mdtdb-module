function New-MDTLocation {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true)] $name,
        [Parameter(ValueFromPipelineByPropertyName=$true)] $gateways,
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $settings
    )

    Process
    {
        # Insert a new role row and get the identity result
        $sql = "INSERT INTO LocationIdentity (Location) VALUES ('$name') SELECT @@IDENTITY"
        Write-Verbose "About to execute command: $sql"
        $identityCmd = New-Object System.Data.SqlClient.SqlCommand($sql, $mdtSQLConnection)
        $identity = $identityCmd.ExecuteScalar()
        Write-Verbose "Added location identity record"
    
        # Set the gateways
        $null = Set-MDTLocation -id $identity -gateways $gateways
        
        # Insert the settings row, adding the values as specified in the hash table
        $settingsColumns = $settings.Keys -join ","
        $settingsValues = $settings.Values -join "','"
        $sql = "INSERT INTO Settings (Type, ID, $settingsColumns) VALUES ('L', $identity, '$settingsValues')"
        Write-Verbose "About to execute command: $sql"
        $settingsCmd = New-Object System.Data.SqlClient.SqlCommand($sql, $mdtSQLConnection)
        $null = $settingsCmd.ExecuteScalar()
            
        Write-Host "Added settings for the specified location"
        
        # Write the new record back to the pipeline
        Get-MDTLocation -ID $identity
    }
}