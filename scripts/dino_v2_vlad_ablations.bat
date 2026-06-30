@echo off
setlocal enabledelayedexpansion

REM ===== Activate Conda =====
call C:\ProgramData\anaconda3\Scripts\activate.bat anyloc

REM ===== Config =====
set CACHE_DIR=H:\Master\Hung\datasets\cache
set DATA_DIR=H:\Master\Hung\datasets\anyloc-dataset

set MODEL=dinov2_vitb14
set LAYER=10
set FACET=value
set CLUSTERS=32

REM ===== Datasets =====
REM set DATASETS=gardens 17places st_lucia hawkins laurel_caverns eiffel Tartan_GNSS_test_rotated Tartan_GNSS_test_notrotated pitts30k VPAir
set DATASETS=VPAir

for %%D in (%DATASETS%) do (

    echo =====================================================
    echo Running Dataset: %%D
    echo =====================================================

    set EXP_ID=ablations/DINO_V2_VLAD/l!LAYER!_!FACET!_c!CLUSTERS!/%%D/!MODEL!

    python dino_v2_vlad.py ^
      --exp-id "!EXP_ID!" ^
      --model-type !MODEL! ^
      --num-clusters !CLUSTERS! ^
      --desc-layer !LAYER! ^
      --desc-facet !FACET! ^
      --prog.cache-dir "!CACHE_DIR!" ^
      --prog.data-vg-dir "!DATA_DIR!" ^
      --prog.vg-dataset-name %%D ^
      --prog.use-wandb ^
      --prog.wandb-proj Paper_Dino-v2_Ablations ^
      --prog.wandb-entity vpr-vl ^
      --prog.wandb-group %%D ^
      --prog.wandb-run-name DINO_V2_VLAD/l!LAYER!_!FACET!_c!CLUSTERS!/%%D/!MODEL!

)

pause