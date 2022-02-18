function Remove-MDTPackageMapping {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true)] $ARPName = "",
        [Parameter(ValueFromPipelineByPropertyName=$true)] $package = ""
    )
    
    Process
    {
        # Build a delete statement based on what parameters were specified
        if ($ARPName -eq "" -and $package -eq "")
        {
            # Dangerous, delete them all
            $sql = "DELETE FROM PackageMapping"
        }
        elseif ($ARPName -ne "" -and $package -ne "")
        {
            $sql = "DELETE FROM PackageMapping WHERE ARPName = '$ARPName' AND Packages = '$package'"
        }
        elseif ($ARPName -ne "")
        {
            $sql = "DELETE FROM PackageMapping WHERE ARPName = '$ARPName'"
        }
        else
        {
            $sql = "DELETE FROM PackageMapping WHERE Packages = '$package'"
        }
        
        # Execute the delete command
        Write-Debug "About to execute command: $sql"
        $settingsCmd = New-Object System.Data.SqlClient.SqlCommand($sql, $mdtSQLConnection)
        $null = $settingsCmd.ExecuteScalar()
        Write-Debug "Removed package mapping records matching the specified parameters."    
    }
}