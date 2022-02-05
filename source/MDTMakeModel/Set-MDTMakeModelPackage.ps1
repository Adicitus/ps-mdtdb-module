function Set-MDTMakeModelPackage {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $id,
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $packages
    )

    Process
    {
        Set-MDTArray $id 'M' 'Settings_Packages' 'Packages' $packages
    }
}