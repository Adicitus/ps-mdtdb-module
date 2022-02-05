function Get-MDTMakeModel {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true)] $id = "",
        [Parameter(ValueFromPipelineByPropertyName=$true)] $make = "",
        [Parameter(ValueFromPipelineByPropertyName=$true)] $model = ""
    )
    
    Process
    {
        # Build a select statement based on what parameters were specified
        if ($id -eq "" -and $make -eq "" -and $model -eq "")
        {
            $sql = "SELECT * FROM MakeModelSettings"
        }
        elseif ($id -ne "")
        {
            $sql = "SELECT * FROM MakeModelSettings WHERE ID = $id"
        }
        elseif ($make -ne "" -and $model -ne "")
        {
            $sql = "SELECT * FROM MakeModelSettings WHERE Make = '$make' AND Model = '$model'"
        }
        elseif ($make -ne "")
        {
            $sql = "SELECT * FROM MakeModelSettings WHERE Make = '$make'"
        }
        else
        {
            $sql = "SELECT * FROM MakeModelSettings WHERE Model = '$model'"
        }
        
        # Execute the statement and return the results    
        $selectAdapter = New-Object System.Data.SqlClient.SqlDataAdapter($sql, $mdtSQLConnection)
        $selectDataset = New-Object System.Data.Dataset
        $null = $selectAdapter.Fill($selectDataset, "MakeModelSettings")
        $selectDataset.Tables[0].Rows
    }
}