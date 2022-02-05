function Get-MDTLocation {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true)] $id = "",
        [Parameter(ValueFromPipelineByPropertyName=$true)] $name = "",
        [Parameter()][switch] $detail = $false
    )
    
    Process
    {
        # Build a select statement based on what parameters were specified
        if ($id -eq "" -and $name -eq "")
        {
            if ($detail)
            {
                $sql = "SELECT * FROM LocationSettings"
            }
            else
            {
                $sql = "SELECT DISTINCT ID, Location FROM LocationSettings"
            }
        }
        elseif ($id -ne "")
        {
            if ($detail)
            {
                $sql = "SELECT * FROM LocationSettings WHERE ID = $id"
            }
            else
            {
                $sql = "SELECT DISTINCT ID, Location FROM LocationSettings WHERE ID = $id"
            }
        }
        else
        {
            if ($detail)
            {
                $sql = "SELECT * FROM LocationSettings WHERE Location = '$name'"
            }
            else
            {
                $sql = "SELECT DISTINCT ID, Location FROM LocationSettings WHERE Location = '$name'"
            }
        }
        
        # Execute the statement and return the results    
        $selectAdapter = New-Object System.Data.SqlClient.SqlDataAdapter($sql, $mdtSQLConnection)
        $selectDataset = New-Object System.Data.Dataset
        $null = $selectAdapter.Fill($selectDataset, "LocationSettings")
        $selectDataset.Tables[0].Rows
    }
}