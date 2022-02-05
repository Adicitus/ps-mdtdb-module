function Get-MDTPackageMapping {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true)] $ARPName = "",
        [Parameter(ValueFromPipelineByPropertyName=$true)] $package = ""
    )
    
    Process
    {
        # Build a select statement based on what parameters were specified
        if ($ARPName -eq "" -and $package -eq "")
        {
            $sql = "SELECT * FROM PackageMapping"
        }
        elseif ($ARPName -ne "" -and $package -ne "")
        {
            $sql = "SELECT * FROM PackageMapping WHERE ARPName = '$ARPName' AND Packages = '$package'"
        }
        elseif ($ARPName -ne "")
        {
            $sql = "SELECT * FROM PackageMapping WHERE ARPName = '$ARPName'"
        }
        else
        {
            $sql = "SELECT * FROM PackageMapping WHERE Packages = '$package'"
        }
        
        # Execute the statement and return the results    
        $selectAdapter = New-Object System.Data.SqlClient.SqlDataAdapter($sql, $mdtSQLConnection)
        $selectDataset = New-Object System.Data.Dataset
        $null = $selectAdapter.Fill($selectDataset, "PackageMapping")
        $selectDataset.Tables[0].Rows
    }
}