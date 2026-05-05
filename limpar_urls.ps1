# Script robusto para renomear pastas para o formato web (slug)
$folders = Get-ChildItem -Directory

function Convert-ToSlug($string) {
    # Converte para minúsculas
    $slug = $string.ToLower()
    
    # Remove acentos e caracteres especiais comuns
    $accents = @{
        'a' = '[áàâãä]'; 'e' = '[éèêë]'; 'i' = '[íìîï]';
        'o' = '[óòôõö]'; 'u' = '[úùûü]'; 'c' = 'ç'; 'n' = 'ñ'
    }
    foreach ($key in $accents.Keys) {
        $slug = [Regex]::Replace($slug, $accents[$key], $key)
    }

    # Troca espaços e caracteres não alfanuméricos por hifen
    $slug = [Regex]::Replace($slug, '[^a-z0-9]', '-')
    
    # Remove hifens duplicados
    $slug = [Regex]::Replace($slug, '-+', '-')
    
    # Remove hifens no início ou fim
    $slug = $slug.Trim('-')
    
    return $slug
}

foreach ($folder in $folders) {
    if ($folder.Name.StartsWith(".")) { continue }

    $newName = Convert-ToSlug($folder.Name)
    
    if ($folder.Name -ne $newName) {
        Write-Host "Renomeando: '$($folder.Name)' -> '$newName'" -ForegroundColor Cyan
        try {
            Rename-Item -Path $folder.FullName -NewName $newName -ErrorAction Stop
        } catch {
            Write-Warning "Nao foi possivel renomear $($folder.Name): $($_.Exception.Message)"
        }
    }
}

Write-Host "`n[+] Pastas renomeadas com sucesso!" -ForegroundColor Green
Write-Host "[i] Lembre-se de rodar 'git add .' e 'git push' para atualizar o site." -ForegroundColor Yellow
Read-Host "Pressione Enter para sair"
