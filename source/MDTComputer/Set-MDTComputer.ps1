function Set-MDTComputer {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $id,
        [Parameter(Mandatory=$true)] $settings
    )
    
    Process
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
        $sql = "$sql WHERE ID = $id AND Type = 'C'"
        
        # Execute the command
        Write-Debug "About to execute command: $sql"        
        $settingsCmd = New-Object System.Data.SqlClient.SqlCommand($sql, $mdtSQLConnection)
        $null = $settingsCmd.ExecuteScalar()
            
        Write-Debug "Added settings for the specified computer"
        
        # Write the updated record back to the pipeline
        Get-MDTComputer -ID $id
    }
}