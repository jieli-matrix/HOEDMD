function main_kerdmd_g(psi_file_path, ddata_dir, alg_type, sigma, S) 
    % run for group mode
    [~, base_name, ~] = fileparts(psi_file_path);
    load(psi_file_path, 'Psi_g', 'p');
        
    erank = min(size(Psi_g));
    if S > erank
        error("S is out of rank!");
    end
    [U,Lambda,V] = hoedmd_ker(Psi_g, p, S, alg_type, sigma);
    base_sname = strcat(base_name, 'S', num2str(S), '.mat');
    mode_file_path = fullfile(ddata_dir, base_sname);
    save(mode_file_path, 'U', 'Lambda', 'V');
end