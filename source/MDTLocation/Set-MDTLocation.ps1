function Set-MDTLocation {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $id,
        [Parameter(ValueFromPipelineByPropertyName=$true)] $gateways = $null,
        [Parameter()] $settings = $null
    )
    
    Process
    {
        # If there are some new settings save them
        if ($settings -ne $null)
        {
            # Add each each hash table entry to the update statement
            $sql = "UPDATE Settings SET"
            foreach ($setting in $settings.GetEnumerator())
            {
                $sql = "$sql $($setting.Key) = '$($setting.Value)', "
            }
        
            # Chop off the trailing ", "
            $sql = $sql.Substring(0, $sql.Length - 2)

            # Add the where clause
            $sql = "$sql WHERE ID = $id AND Type = 'L'"
        
            # Execute the command
            Write-Verbose "About to execute command: $sql"        
            $settingsCmd = New-Object System.Data.SqlClient.SqlCommand($sql, $mdtSQLConnection)
            $null = $settingsCmd.ExecuteScalar()
            
            Write-Host "Added settings for the specified location"
        }
        
        # If there are some gateways save them
        if ($gateways -ne $null)
        {
            # Build the delete command to remove the existing gateways
            $delCommand = "DELETE FROM LocationIdentity_DefaultGateway WHERE ID = $id"
        
            # Issue the delete command
            Write-Verbose "About to issue command: $delCommand"
            $cmd = New-Object System.Data.SqlClient.SqlCommand($delCommand, $mdtSQLConnection)
            $null = $cmd.ExecuteScalar()
            
            # Now insert the specified values
            foreach ($gateway in $gateways)
            {
                # Insert the  row
                $sql = "INSERT INTO LocationIdentity_DefaultGateway (ID, DefaultGateway) VALUES ($id, '$gateway')"
                Write-Verbose "About to execute command: $sql"
                $settingsCmd = New-Object System.Data.SqlClient.SqlCommand($sql, $mdtSQLConnection)
                $null = $settingsCmd.ExecuteScalar()

            }
            Write-Host "Set the default gateways for the location with ID = $id."    
        }
        
        # Write the updated record back to the pipeline
        Get-MDTLocation -ID $id
    }
}