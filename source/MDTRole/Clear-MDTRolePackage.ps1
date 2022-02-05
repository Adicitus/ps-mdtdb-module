function Clear-MDTRolePackage {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $id
    )

    Process
    {
        Clear-MDTArray $id 'R' 'Settings_Packages'
    }
}