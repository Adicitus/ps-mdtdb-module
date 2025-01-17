function New-MDTComputer {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true)] $assetTag,
        [ValidatePattern('^(([0-9A-F]{2}){5}|([0-9A-F]{2}-){5}|([0-9A-F]{2}:){5})[0-9A-F]{2}$')]
        [Parameter(ValueFromPipelineByPropertyName=$true)] $macAddress,
        [Parameter(ValueFromPipelineByPropertyName=$true)] $serialNumber,
        [Parameter(ValueFromPipelineByPropertyName=$true)] $uuid,
        [Parameter(ValueFromPipelineByPropertyName=$true)] $description,
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $settings
    )

    Process
    {
        if ($macAddress) {
            $macAddress = _ensureMACAddressFormat $macAddress
        }
        
        # Insert a new computer row and get the identity result
        $sql = "INSERT INTO ComputerIdentity (AssetTag, SerialNumber, MacAddress, UUID, Description) VALUES ('$assetTag', '$serialNumber', '$macAddress', '$uuid', '$description') SELECT @@IDENTITY"
        Write-Debug "About to execute command: $sql"
        $identityCmd = New-Object System.Data.SqlClient.SqlCommand($sql, $mdtSQLConnection)
        $identity = $identityCmd.ExecuteScalar()
        Write-Debug "Added computer identity record"
    
        # Insert the settings row, adding the values as specified in the hash table
        $settingsColumns = $settings.Keys -join ","
        $settingsValues = $settings.Values -join "','"
        $sql = "INSERT INTO Settings (Type, ID, $settingsColumns) VALUES ('C', $identity, '$settingsValues')"
        Write-Debug "About to execute command: $sql"
        $settingsCmd = New-Object System.Data.SqlClient.SqlCommand($sql, $mdtSQLConnection)
        $null = $settingsCmd.ExecuteScalar()
            
        Write-Debug "Added settings for the specified computer"
        
        # Write the new record back to the pipeline
        Get-MDTComputer -ID $identity
    }
}