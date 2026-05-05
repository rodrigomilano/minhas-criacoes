# Script FINAL para renomear pastas e CORRIGIR LETRAS MAIUSCULAS no Windows
$folders = Get-ChildItem -Directory

function Convert-ToSlug($string) {
    $slug = $string.ToLower()
    $accents = @{
        'a' = '[áàâãä]'; 'e' = '[éèêë]'; 'i' = '[íìîï]';
        'o' = '[óòôõö]'; 'u' = '[úùûü]'; 'c' = 'ç'; 'n' = 'ñ'
    }
    foreach ($key in $accents.Keys) { $slug = [Regex]::Replace($slug, $accents[$key], $key) }
    $slug = [Regex]::Replace($slug, '[^a-z0-9]', '-')
    $slug = [Regex]::Replace($slug, '-+', '-')
    return $slug.Trim('-')
}

foreach ($folder in $folders) {
    if ($folder.Name.StartsWith(".")) { continue }

    $newName = Convert-ToSlug($folder.Name)
    
    # IMPORTANTE: Se o nome for o mesmo mas a letra mudar (A vs a), 
    # o Windows ignora. Precisamos de um nome temporario.
    if ($folder.Name -clike $newName) {
        # Ja esta certo, nao faz nada
    } else {
        Write-Host "Corrigindo: '$($folder.Name)' -> '$newName'" -ForegroundColor Cyan
        $tempName = $newName + "_temp_" + (Get-Random)
        
        try {
            # Passo 1: Renomeia para nome temporario
            Rename-Item -Path $folder.FullName -NewName $tempName -ErrorAction Stop
            # Passo 2: Renomeia para o nome final minusculo
            Rename-Item -Path "$($folder.Parent.FullName)\$tempName" -NewName $newName -ErrorAction Stop
        } catch {
            Write-Warning "Erro ao processar $($folder.Name): $($_.Exception.Message)"
        }
    }
}

Write-Host "`n[+] Pastas corrigidas com sucesso!" -ForegroundColor Green
Read-Host "Pressione Enter para sair"
