function Get-MDTRole {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true)] $id = "",
        [Parameter(ValueFromPipelineByPropertyName=$true)] $name = ""
    )
    
    Process
    {
        # Build a select statement based on what parameters were specified
        if ($id -eq "" -and $name -eq "")
        {
            $sql = "SELECT * FROM RoleSettings"
        }
        elseif ($id -ne "")
        {
            $sql = "SELECT * FROM RoleSettings WHERE ID = $id"
        }
        else
        {
            $sql = "SELECT * FROM RoleSettings WHERE Role = '$name'"
        }
        
        # Execute the statement and return the results    
        $selectAdapter = New-Object System.Data.SqlClient.SqlDataAdapter($sql, $mdtSQLConnection)
        $selectDataset = New-Object System.Data.Dataset
        $null = $selectAdapter.Fill($selectDataset, "RoleSettings")
        $selectDataset.Tables[0].Rows
    }
}