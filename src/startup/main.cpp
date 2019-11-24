// Include header files for STM32
#include <stm32f4xx_hal.h>
#include <stm32f4xx_hal_gpio.h>
#include <stm32f4xx_hal_uart.h>
#include <string.h>

// Declare a pointer to a UART_HandleTypeDef structure
UART_HandleTypeDef huart;
// Declare a pointer to a GPIO_InitTypeDef structure
GPIO_InitTypeDef ginit;

// Constants
#define NUMBER_CHARACTERS 36
#define SYSTEM_CLOCK 16000000
#define CONVERT_TO_SECONDS 1000
#define DOT_LENGTH 100
#define DASH_LENGTH 300
#define SAME_LETTER_SPACE_LENGTH 100
#define DIFFERENT_LETTER_SPACE_LENGTH 200
#define MAX_MORSE_SIZE 6
#define WORDS_SPACE_LENGTH 600

// HAL wants these clock configuration variables defined
uint32_t SystemCoreClock = SYSTEM_CLOCK;
const uint8_t AHBPrescTable[16] = {0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3, 4, 6, 7, 8, 9};
const uint8_t APBPrescTable[8]  = {0, 0, 0, 0, 1, 2, 3, 4};

// Array for input to keyboard
char characters[NUMBER_CHARACTERS] = {'A','B','C','D','E','F','G','H','I','J','K','L',
'M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','1','2','3','4',
'5','6','7','8','9','0'};

/*
"." -> DOT 
"-" -> DASH
*/
const char morseConversion[NUMBER_CHARACTERS][MAX_MORSE_SIZE] = {".-","-...","-.-.","-..",".","..-.","--.","....","..",".---", "-.-",
".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--..",".----",
"..---","...--","....-",".....","-....","--...","---..","----.","-----"};

// Output a dot onto the Green LED on STM 32
// Follow with a short delay between dot/dash in same letter
void outputDot(){
    HAL_GPIO_WritePin(GPIOA, GPIO_PIN_5, GPIO_PIN_SET);
    HAL_Delay(DOT_LENGTH);
    HAL_GPIO_WritePin(GPIOA, GPIO_PIN_5, GPIO_PIN_RESET);
    HAL_Delay(SAME_LETTER_SPACE_LENGTH);
}

// Output a dash onto the Green LED on STM 32
// Follow with a short delay between dot/dash in same letter
void outputDash(){
    HAL_GPIO_WritePin(GPIOA, GPIO_PIN_5, GPIO_PIN_SET);
    HAL_Delay(DASH_LENGTH);
    HAL_GPIO_WritePin(GPIOA, GPIO_PIN_5, GPIO_PIN_RESET);
    HAL_Delay(SAME_LETTER_SPACE_LENGTH);
}

// Output a delay onto the Green LED on STM 32 to indicate change in letter
void changeLetter(){
   HAL_Delay(DIFFERENT_LETTER_SPACE_LENGTH);
}

// Output a delay onto the Green LED on STM 32 to indicate change in word
void changeWord(){
    HAL_Delay(WORDS_SPACE_LENGTH);
}


// Return the index in which the morse character is stored
// If morse character not found, return -1 for invalid input
int returnMorseForCharacter(char userCharacter){
    int arrayIndex;

    for (arrayIndex = 0; arrayIndex < NUMBER_CHARACTERS; arrayIndex++){
        if (characters[arrayIndex] == userCharacter){
            return arrayIndex;
        } 
    }
    // Return for invalid input
    return -1;
}

// Output the morse code for a given character onto the STM 32
// Include delay after each character to differentiate on LED
void outputCharacter(char* morseString){
    int index;
    int length = strlen(morseString);

    for (index = 0; index < length; index++){
        if (morseString[index] == '.'){
            outputDot();
        }
        else if (morseString[index] == '-'){
            outputDash();
        }
    }
    // Need to have a delay in between different letters
    changeLetter();
}

// Convert the string input by the user into morse code
void convertStringToMorse(char* userString, int length){
    int index, morseIndex;
    char letter;
    char morse[MAX_MORSE_SIZE];

    for (index = 0; index < length; index++){
        letter = userString[index];
        if (letter == ' '){
            changeWord();
        }
        else {
            morseIndex = returnMorseForCharacter(letter);
            // Only output morse for valid user input
            if (morseIndex != -1){
                // Copy the morse code into an array to be used as parameter for output
                strcpy(morse,morseConversion[morseIndex]);
                outputCharacter(morse);
            }
        }
    }
}

// Main function 
extern "C"
int main() {
    HAL_SYSTICK_Config(SYSTEM_CLOCK/CONVERT_TO_SECONDS);
    
    // Set up GPIOA for UART module and for Green LED output of morse code
    __HAL_RCC_GPIOA_CLK_ENABLE();

    // Initialization conditions for GPIOA
    ginit.Pin = GPIO_PIN_2 | GPIO_PIN_3;
    ginit.Mode = GPIO_MODE_AF_PP;
    ginit.Speed = GPIO_SPEED_LOW;
    ginit.Pull = GPIO_NOPULL;
    ginit.Alternate = GPIO_AF7_USART2;

    // Initialize the GPIOA according to parameters in GPIO_InitTypeDef in preparation for UART module 
    HAL_GPIO_Init(GPIOA, &ginit);

    __HAL_RCC_USART2_CLK_ENABLE();

    // Specify configuration information for UART module
    huart.Instance = USART2;
    huart.Init.BaudRate = 9600;
    huart.Init.WordLength = UART_WORDLENGTH_8B;
    huart.Init.StopBits = UART_STOPBITS_1;
    huart.Init.Parity = UART_PARITY_NONE; 
    huart.Init.Mode = UART_MODE_TX_RX;
    huart.Init.HwFlowCtl = UART_HWCONTROL_NONE;
    huart.Init.OverSampling = UART_OVERSAMPLING_8;

    // Initialize UART mode according to parameters in UART_HandleTypeDef 
    HAL_UART_Init(&huart);

    // Declare variable for size of string to convert into morse code.
    uint8_t string_length[1];
    
    // Prompt user for length of the phrase they wish to convert into morse code.
    // Note only capital letters and Arabic numerals will be converted. 
    HAL_UART_Transmit(&huart, (uint8_t*)"Size of phrase to convert into Morse Code (Only Capital letters and Arabic numerals, size less than 10): ",
        strlen("Size of phrase to convert into Morse Code (Only Capital letters and Arabic numerals, size less than 10): "), HAL_MAX_DELAY);
    // Receive size of string to convert into morse code.
    HAL_UART_Receive(&huart, string_length, 1, HAL_MAX_DELAY);
    // Let user know what size is being input into terminal
    HAL_UART_Transmit(&huart, string_length, 1, HAL_MAX_DELAY);

    // Subtract the string_length by 0 to account for the ASCII value associated with the character
    string_length[0] = string_length[0] - '0'; 

    // Check if input cannot be converted into positive integer size according to specifications
    if (string_length[0] < 0 || string_length[0] > 9){
        return -1;
    } 

    // Declare variable for string to convert into morse code.
    uint8_t user_string[string_length[0]];

    // Prompt user for string to convert into morse code.
    HAL_UART_Transmit(&huart, (uint8_t*)" Phrase to convert: ", strlen(" Phrase to convert: "), HAL_MAX_DELAY);
    // Receive string to convert into morse code.
    HAL_UART_Receive(&huart, user_string, string_length[0], HAL_MAX_DELAY);
    // Let user know what string is being input into terminal
    HAL_UART_Transmit(&huart, user_string, string_length[0], HAL_MAX_DELAY);

    // Initialization conditions for Green LED 
    ginit.Mode = GPIO_MODE_OUTPUT_PP;
    ginit.Pin = GPIO_PIN_5;
    ginit.Pull = GPIO_NOPULL;
    ginit.Speed = GPIO_SPEED_LOW;

    // Initialize the GPIOA (Green LED) according to parameters in GPIO_InitTypeDef 
    HAL_GPIO_Init(GPIOA, &ginit);

    // Reset the Green LED 
    HAL_GPIO_WritePin(GPIOA, GPIO_PIN_5, GPIO_PIN_RESET);

    convertStringToMorse((char*)user_string, string_length[0]);
    
    while (1){}
}


// Interrupt -> Used to check change in hardware state of STM 32
extern "C"
void handle_systick(){
    HAL_IncTick();
}