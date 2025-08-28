# ===============================
# Compiladores y flags
# ===============================
CC  = gcc
CXX = g++
CFLAGS = -Wall -g
CXXFLAGS = -Wall -g -pthread

# ===============================
# Directorios
# ===============================
SRC_DIR_CAPITULO1 = SRC/Capitulo1
BIN_DIR_CAPITULO1 = bin/Capitulo1

SRC_DIR_CAPITULO2 = SRC/Capitulo2
BIN_DIR_CAPITULO2 = bin/Capitulo2

SRC_DIR_CAPITULO3 = SRC/Capitulo3
BIN_DIR_CAPITULO3 = bin/Capitulo3

SRC_DIR_CAPITULO4 = SRC/Capitulo4
BIN_DIR_CAPITULO4 = bin/Capitulo4

SRC_DIR_CAPITULO5 = SRC/Capitulo5
BIN_DIR_CAPITULO5 = bin/Capitulo5

# ===============================
# CAPÍTULO 1
# ===============================
CAP1_SRC_C   = $(SRC_DIR_CAPITULO1)/Listing1_1.c
CAP1_SRC_CPP = $(SRC_DIR_CAPITULO1)/Listing1_2.cpp
CAP1_HDR     = $(SRC_DIR_CAPITULO1)/Listing1_3.hpp

CAP1_OBJ = $(BIN_DIR_CAPITULO1)/Listing1_1.o $(BIN_DIR_CAPITULO1)/Listing1_2.o
CAP1_BIN = $(BIN_DIR_CAPITULO1)/programa_cap1

# ===============================
# CAPÍTULO 2
# ===============================
CAP2_SIMPLE_SRC  = $(SRC_DIR_CAPITULO2)/Listing2_1.c $(SRC_DIR_CAPITULO2)/Listing2_2.c \
                   $(SRC_DIR_CAPITULO2)/Listing2_3.c $(SRC_DIR_CAPITULO2)/Listing2_4.c \
                   $(SRC_DIR_CAPITULO2)/Listing2_5.c $(SRC_DIR_CAPITULO2)/Listing2_6.c
CAP2_SIMPLE_BINS = $(patsubst $(SRC_DIR_CAPITULO2)/%.c,$(BIN_DIR_CAPITULO2)/%,$(CAP2_SIMPLE_SRC))

CAP2_LIST27 = $(SRC_DIR_CAPITULO2)/Listing2_7.c
CAP2_LIST28 = $(SRC_DIR_CAPITULO2)/Listing2_8.c
CAP2_LIST29 = $(SRC_DIR_CAPITULO2)/Listing2_9.c

CAP2_LIB      = $(BIN_DIR_CAPITULO2)/libtest.a
CAP2_APP_OBJ  = $(BIN_DIR_CAPITULO2)/Listing2_8.o
CAP2_APP_BIN  = $(BIN_DIR_CAPITULO2)/app
CAP2_TIFF_BIN = $(BIN_DIR_CAPITULO2)/tifftest

# ===============================
# CAPÍTULO 3
# ===============================
CAP3_SRC  = $(wildcard $(SRC_DIR_CAPITULO3)/*.c)
CAP3_BINS = $(patsubst $(SRC_DIR_CAPITULO3)/%.c,$(BIN_DIR_CAPITULO3)/%,$(CAP3_SRC))

# ===============================
# CAPÍTULO 4
# ===============================
CAP4_SRC_C   = $(wildcard $(SRC_DIR_CAPITULO4)/Listing4*.c)
CAP4_SRC_CPP = $(wildcard $(SRC_DIR_CAPITULO4)/Listing4*.cpp)

CAP4_BINS_C   = $(patsubst $(SRC_DIR_CAPITULO4)/%.c,$(BIN_DIR_CAPITULO4)/%,$(CAP4_SRC_C))
CAP4_BINS_CPP = $(patsubst $(SRC_DIR_CAPITULO4)/%.cpp,$(BIN_DIR_CAPITULO4)/%,$(CAP4_SRC_CPP))

CAP4_BINS = $(CAP4_BINS_C) $(CAP4_BINS_CPP)

# ===============================
# CAPÍTULO 5
# ===============================
CAP5_SRC  = $(wildcard $(SRC_DIR_CAPITULO5)/*.c)
CAP5_BINS = $(patsubst $(SRC_DIR_CAPITULO5)/%.c,$(BIN_DIR_CAPITULO5)/%,$(CAP5_SRC))

# ===============================
# OBJETIVO PRINCIPAL
# ===============================
all: cap1 cap2 cap3 cap4 cap5

# -------------------------------
# CAPÍTULO 1
# -------------------------------
cap1: $(CAP1_BIN)

$(CAP1_BIN): $(CAP1_OBJ)
	@mkdir -p $(BIN_DIR_CAPITULO1)
	$(CXX) -o $@ $(CAP1_OBJ)

$(BIN_DIR_CAPITULO1)/Listing1_1.o: $(CAP1_SRC_C) $(CAP1_HDR)
	@mkdir -p $(BIN_DIR_CAPITULO1)
	$(CC) $(CFLAGS) -c $< -o $@

$(BIN_DIR_CAPITULO1)/Listing1_2.o: $(CAP1_SRC_CPP) $(CAP1_HDR)
	@mkdir -p $(BIN_DIR_CAPITULO1)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Alias
Listing1_1:
	@echo "Listing1_1 no es ejecutable por sí solo. Usa 'make cap1'."

Listing1_2:
	@echo "Listing1_2 no es ejecutable por sí solo. Usa 'make cap1'."

# -------------------------------
# CAPÍTULO 2
# -------------------------------
cap2: $(CAP2_SIMPLE_BINS) $(CAP2_APP_BIN) $(CAP2_TIFF_BIN)

# Listings simples (2_1–2_6)
$(BIN_DIR_CAPITULO2)/%: $(SRC_DIR_CAPITULO2)/%.c
	@mkdir -p $(BIN_DIR_CAPITULO2)
	$(CC) $(CFLAGS) $< -o $@

Listing2_%: $(BIN_DIR_CAPITULO2)/Listing2_%
	@true

# Librería estática Listing2_7
$(CAP2_LIB): $(CAP2_LIST27)
	@mkdir -p $(BIN_DIR_CAPITULO2)
	$(CC) $(CFLAGS) -c $< -o $(BIN_DIR_CAPITULO2)/Listing2_7.o
	ar cr $@ $(BIN_DIR_CAPITULO2)/Listing2_7.o

Listing2_7:
	@echo "Listing2_7 no es ejecutable, se usa en libtest.a"

# Programa app (Listing2_8 usa libtest.a)
$(CAP2_APP_OBJ): $(CAP2_LIST28)
	@mkdir -p $(BIN_DIR_CAPITULO2)
	$(CC) $(CFLAGS) -c $< -o $@

$(CAP2_APP_BIN): $(CAP2_APP_OBJ) $(CAP2_LIB)
	$(CC) -o $@ $(CAP2_APP_OBJ) -L$(BIN_DIR_CAPITULO2) -ltest

Listing2_8: $(CAP2_APP_BIN)
	@true

# Programa tifftest (Listing2_9)
$(CAP2_TIFF_BIN): $(CAP2_LIST29)
	@mkdir -p $(BIN_DIR_CAPITULO2)
	$(CC) $(CFLAGS) $< -o $@ -ltiff

Listing2_9: $(CAP2_TIFF_BIN)
	@true

run_tiff: $(CAP2_TIFF_BIN)
	@if [ -f archivo.tiff ]; then \
		echo "[INFO] Ejecutando tifftest con archivo.tiff..."; \
		$(CAP2_TIFF_BIN) archivo.tiff; \
		display archivo.tiff & \
	else \
		echo "[WARN] No se encontró archivo.tiff en este directorio."; \
	fi

# -------------------------------
# CAPÍTULO 3
# -------------------------------
cap3: $(CAP3_BINS)

$(BIN_DIR_CAPITULO3)/%: $(SRC_DIR_CAPITULO3)/%.c
	@mkdir -p $(BIN_DIR_CAPITULO3)
	$(CC) $(CFLAGS) $< -o $@

Listing3_%: $(BIN_DIR_CAPITULO3)/Listing3_%
	@true

# -------------------------------
# CAPÍTULO 4
# -------------------------------
cap4: $(CAP4_BINS)

$(BIN_DIR_CAPITULO4)/%: $(SRC_DIR_CAPITULO4)/%.c
	@mkdir -p $(BIN_DIR_CAPITULO4)
	$(CC) $(CFLAGS) $< -o $@

$(BIN_DIR_CAPITULO4)/%: $(SRC_DIR_CAPITULO4)/%.cpp
	@mkdir -p $(BIN_DIR_CAPITULO4)
	$(CXX) $(CXXFLAGS) $< -o $@

Listing4_%: $(BIN_DIR_CAPITULO4)/Listing4_%
	@true

# -------------------------------
# CAPÍTULO 5
# -------------------------------
cap5: $(CAP5_BINS)

$(BIN_DIR_CAPITULO5)/%: $(SRC_DIR_CAPITULO5)/%.c
	@mkdir -p $(BIN_DIR_CAPITULO5)
	$(CC) $(CFLAGS) $< -o $@

Listing5_%: $(BIN_DIR_CAPITULO5)/Listing5_%
	@true

# -------------------------------
# LIMPIEZA
# -------------------------------
clean:
	rm -rf bin/Capitulo1 bin/Capitulo2 bin/Capitulo3 bin/Capitulo4 bin/Capitulo5
