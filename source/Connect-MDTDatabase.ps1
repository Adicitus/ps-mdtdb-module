function Connect-MDTDatabase {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(Position=1)] $drivePath = "",
        [Parameter()] $sqlServer,
        [Parameter()] $instance = "",
        [Parameter()] $database
    )

    # If $mdtDatabase exists from a previous execution, clear it
    if ($mdtDatabase)
    {
        Clear-Variable -name mdtDatabase
    }

    # If a drive path is specified, use PowerShell to build the connection string.
    # Otherwise, build it from the other parameters
    if ($drivePath -ne "")
    {
        # Get the needed properties to build the connection string    
        $mdtProperties = get-itemproperty $drivePath

        $mdtSQLConnectString = "Server=$($mdtProperties.'Database.SQLServer')"
        if ($mdtProperties."Database.Instance" -ne "")
        {
            $mdtSQLConnectString = "$mdtSQLConnectString\$($mdtProperties.'Database.Instance')"
        }
        $mdtSQLConnectString = "$mdtSQLConnectString; Database='$($mdtProperties.'Database.Name')'; Integrated Security=true;"
    }
    else
    {
        $mdtSQLConnectString = "Server=$($sqlServer)"
        if ($instance -ne "")
        {
            $mdtSQLConnectString = "$mdtSQLConnectString\$instance"
        }
        $mdtSQLConnectString = "$mdtSQLConnectString; Database='$database'; Integrated Security=true;"
    }
    
    # Make the connection and save it in a global variable
    Write-Host "Connecting to: $mdtSQLConnectString"
    $global:mdtSQLConnection = new-object System.Data.SqlClient.SqlConnection
    $global:mdtSQLConnection.ConnectionString = $mdtSQLConnectString
    $global:mdtSQLConnection.Open()
}