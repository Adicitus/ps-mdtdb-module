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

        if ($macAddress) {
            $macAddress = _ensureMACAddressFormat $macAddress
        }

        $sql = "SELECT ci.Description, ci.AssetTag, ci.UUID, ci.SerialNumber, ci.MacAddress, s.* FROM dbo.ComputerIdentity AS ci INNER JOIN dbo.Settings AS S ON s.id = ci.id WHERE s.Type = 'C'"

        # Build a select statement based on what parameters were specified
        if ($id -eq "" -and $assetTag -eq "" -and $macAddress -eq "" -and $serialNumber -eq "" -and $uuid -eq "" -and $description -eq "")
        {
            $sql = $sql
        }
        elseif ($id -ne "")
        {
            $sql = "$sql AND ci.ID = $id"
        }
        else
        {
            # Specified the initial command
            $sql = "$sql AND"
        
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
                if ($description.Contains('*')) {
                    $t = $description.Replace('*','%')
                    $sql = "$sql Description LIKE '$t' AND"
                } else {
                    $sql = "$sql Description='$description' AND"
                }
            }
    
            # Chop off the last " AND"
            $sql = $sql.Substring(0, $sql.Length - 4)
        }
    
        $selectAdapter = New-Object System.Data.SqlClient.SqlDataAdapter($sql, $mdtSQLConnection)
        $selectDataset = New-Object System.Data.Dataset
        $null = $selectAdapter.Fill($selectDataset, "Settings")
        $selectDataset.Tables[0].Rows
    }
}