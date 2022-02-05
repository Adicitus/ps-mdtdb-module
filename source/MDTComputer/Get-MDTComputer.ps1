function Get-MDTComputer {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true)] $id = "",
        [Parameter(ValueFromPipelineByPropertyName=$true)] $assetTag = "",
        [Parameter(ValueFromPipelineByPropertyName=$true)] $macAddress = "",
        [Parameter(ValueFromPipelineByPropertyName=$true)] $serialNumber = "",
        [Parameter(ValueFromPipelineByPropertyName=$true)] $uuid = "",
        [Parameter(ValueFromPipelineByPropertyName=$true)] $description = ""
    )
    
    Process
    {
        # Build a select statement based on what parameters were specified
        if ($id -eq "" -and $assetTag -eq "" -and $macAddress -eq "" -and $serialNumber -eq "" -and $uuid -eq "" -and $description -eq "")
        {
            $sql = "SELECT * FROM ComputerSettings"
        }
        elseif ($id -ne "")
        {
            $sql = "SELECT * FROM ComputerSettings WHERE ID = $id"
        }
        else
        {
            # Specified the initial command
            $sql = "SELECT * FROM ComputerSettings WHERE "
        
            # Add the appropriate where clauses
            if ($assetTag -ne "")
            {
                $sql = "$sql AssetTag='$assetTag' AND"
            }
        
            if ($macAddress -ne "")
            {
                $sql = "$sql MacAddress='$macAddress' AND"
            }

            if ($serialNumber -ne "")
            {
                $sql = "$sql SerialNumber='$serialNumber' AND"
            }

            if ($uuid -ne "")
            {
                $sql = "$sql UUID='$uuid' AND"
            }

            if ($description -ne "")
            {
                $sql = "$sql Description='$description' AND"
            }
    
            # Chop off the last " AND"
            $sql = $sql.Substring(0, $sql.Length - 4)
        }
    
        $selectAdapter = New-Object System.Data.SqlClient.SqlDataAdapter($sql, $mdtSQLConnection)
        $selectDataset = New-Object System.Data.Dataset
        $null = $selectAdapter.Fill($selectDataset, "ComputerSettings")
        $selectDataset.Tables[0].Rows
    }
}