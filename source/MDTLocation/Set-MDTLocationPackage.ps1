function Set-MDTLocationPackage {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $id,
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $packages
    )

    Process
    {
        Set-MDTArray $id 'L' 'Settings_Packages' 'Packages' $packages
    }
}