
function WeakUserPasswords {
    <#
        .SYNOPSIS
            Creates a Group in an active directory environment based on random data
        
        .DESCRIPTION
            Starting with the root container this tool randomly places users in the domain.
        

        .PARAMETER UserList
            The stored value of get-aduser -filter {SOMETHING}.  This is used to remove pre-auth on those users.
        
        .EXAMPLE
            
     
        
        .NOTES
            
            #==============================
            # Set Does Not Require Pre-Auth for ASREP Source originally froun Sussurro
            #==============================\
            Unless required by applicable law or agreed to in writing, software
            distributed under the License is distributed on an "AS IS" BASIS,
            WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
            See the License for the specific language governing permissions and
            limitations under the License.
            
            Author's blog: https://www.secframe.com
    
        
    #>

    [CmdletBinding()]
    param
    (
    [Parameter(Mandatory = $false,
            Position = 1,
            HelpMessage = 'Supply a user list from get-aduser to remove pre authentication')]
            [Object[]]$UserList
    )
    $BadPasswords = @('Welkom01!','Welcome22!','Summer2022!','Spring2022!','August22!','September21!','#Password22','Winter22!','Password22!','Password2022!');
    
    foreach($user in $UserList){
        $RandomPassword = Get-random $BadPasswords
        write-host $RandomPassword
        $User | Set-ADAccountPassword -Reset -NewPassword (ConvertTo-SecureString $RandomPassword -AsPlainText -Force)
    }
	
    
}
