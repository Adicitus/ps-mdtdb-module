function Set-MDTComputerPackage {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $id,
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $packages
    )

    Process
    {
        Set-MDTArray $id 'C' 'Settings_Packages' 'Packages' $packages
    }
}