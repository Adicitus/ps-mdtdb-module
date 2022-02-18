function New-MDTMakeModel {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true)] $make,
        [Parameter(ValueFromPipelineByPropertyName=$true)] $model,
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $settings
    )

    Process
    {
        # Insert a new role row and get the identity result
        $sql = "INSERT INTO MakeModelIdentity (Make, Model) VALUES ('$make', '$model') SELECT @@IDENTITY"
        Write-Debug "About to execute command: $sql"
        $identityCmd = New-Object System.Data.SqlClient.SqlCommand($sql, $mdtSQLConnection)
        $identity = $identityCmd.ExecuteScalar()
        Write-Debug "Added make model identity record"
    
        # Insert the settings row, adding the values as specified in the hash table
        $settingsColumns = $settings.Keys -join ","
        $settingsValues = $settings.Values -join "','"
        $sql = "INSERT INTO Settings (Type, ID, $settingsColumns) VALUES ('M', $identity, '$settingsValues')"
        Write-Debug "About to execute command: $sql"
        $settingsCmd = New-Object System.Data.SqlClient.SqlCommand($sql, $mdtSQLConnection)
        $null = $settingsCmd.ExecuteScalar()
            
        Write-Debug "Added settings for the specified make model"
        
        # Write the new record back to the pipeline
        Get-MDTMakeModel -ID $identity
    }
}