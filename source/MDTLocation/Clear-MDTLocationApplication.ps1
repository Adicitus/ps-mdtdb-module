function Clear-MDTLocationApplication {

    [CmdletBinding()]
    PARAM
    (
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true)] $id
    )

    Process
    {
        Clear-MDTArray $id 'L' 'Settings_Applications'
    }
}