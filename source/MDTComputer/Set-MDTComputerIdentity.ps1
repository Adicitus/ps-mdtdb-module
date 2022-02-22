function Set-MDTComputerIdentity {
    [CmdletBinding()]
        param
        (
            [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $id,
            [Parameter(Mandatory=$true)] [Hashtable]$settings
        )
        
        Process
        {

            if ($settings.ContainsKey('MacAddress')) {
                $settings.macAddress = _ensureMACAddressFormat $settings.macAddress
            } 

            # Add each each hash table entry to the update statement
            $sql = "UPDATE ComputerIdentity SET"
            foreach ($setting in $settings.GetEnumerator())
            {
                $sql = "$sql $($setting.Key) = '$($setting.Value)', "
            }
            
            # Chop off the trailing ", "
            $sql = $sql.Substring(0, $sql.Length - 2)
    
            # Add the where clause
            $sql = "$sql WHERE ID = $id"
            
            # Execute the command
            Write-Debug "About to execute command: $sql"        
            $settingsCmd = New-Object System.Data.SqlClient.SqlCommand($sql, $mdtSQLConnection)
            $null = $settingsCmd.ExecuteScalar()
                
            Write-Debug "Update settings for the specified computer"
            
            # Write the updated record back to the pipeline
            Get-MDTComputer -ID $id
        }
    }