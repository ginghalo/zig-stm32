# Configuration

## Basic parameter

Using board: Blue pill

Entry symbol: _start

### Memory:

|Type       |   Value    |   Unit   | 
|:--:       |   :--:     |   :--:   |
|stack      |   800H     |   B      |
|heap       |   400H     |   B      |
|flash      |   64       |   kB     |
|ram        |   20       |   kB     |

### Frequency:

PLL source: High Speed Clock (HSE)

|Type       |   Value    |   Unit   | 
|:--:       |   :--:     |   :--:   |
|lsi        |   40       |   kHz    |
|hsi        |   8        |   MHz    |
|hse        |   8        |   MHz    |
|sysclk     |   16       |   MHz    |
|pllclk     |   8        |   MHz    |
|hclk       |   2        |   MHz    |
|pclk1      |   2        |   MHz    |
|pclk2      |   2        |   MHz    |


## GPIO Usage

|Peripheral |   Function    |     GPIO Type |   Port-Pin |
|:--:       |   :--:        |     :--:      |   :--:     |
|rcc        |   HSE-OSC-IN  |     Input     |   D-0      |
|           |   HSE-OSC-OUT |     Output    |   D-1      |
|           |   MCO         |     Output    |   A-8      |
|sw-dp      |   SWDIO       |     Input     |   A-13     |
|           |   SWCLK       |     Input     |   A-14     |
|uart1      |   TXD         |     Output    |   A-10     |
|           |   RXD         |     Input     |   A-9      |
|i2c2       |   SCL         |     Output    |   B-10     |
|           |   SDA         |     Output    |   B-11     |
|spi1       |   SCLK        |     Output    |   A-5      |
|           |   MISO        |     Input     |   A-6      |
|           |   MOSI        |     Output    |   A-7      |
|spi2       |   SCLK        |     Input     |   B-13     |
|           |   MISO        |     Output    |   B-14     |
|           |   MOSI        |     Input     |   B-15     |
|           |   NSS         |     Input     |   B-12     |
|tim        |   CH1-PWM1    |     Output    |   A-0      |  
|           |   CH2-OC      |     Output    |   A-1      | 
|adc1       |   CH2         |     Input     |   A-2      |
|           |   CH3         |     Input     |   A-3      |
|gpio       |   SSD1306-RES |     Output    |   C-13     |
|           |   SSD1306-DC  |     Output    |   B-1      |
|           |   SSD1306-CS  |     Output    |   B-0      |
|           |   W25Q64-CS   |     Output    |   A-4      |
|           |   KEY-R1      |     Output    |   A-15     |
|           |   KEY-R2      |     Output    |   B-3      |
|           |   KEY-R3      |     Output    |   B-4      |
|           |   KEY-R4      |     Output    |   B-5      |
|           |   KEY-C1      |     Input     |   B-9      |
|           |   KEY-C2      |     Input     |   B-8      |
|           |   KEY-C3      |     Input     |   B-7      |
|           |   KEY-C4      |     Input     |   B-6      |

## Interrupt Usage

|   Interrupt  | Position |
|   :--:       | :--:     |
|   systick    | 003CH    |
|   pvdg       | 0044H    |
|   rtc        | 004CH    |
|   dma1c1     | 006CH    |
|   dma1c3     | 0074H    |
|   dma1c5     | 007CH    |
|   exti9_5    | 009CH    |
|   tim2       | 00B0H    |
|   spi2       | 00CCH    |
|   uart1      | 00D4H    |

## DMA Usage

|No  |  Channel    |   Request    |
|:--:|  :--:       |   :--:       |
|1   |  1          |   ADC1       |
|    |  3          |   SPI1-TX    |
|    |  5          |   UART1-RX   |
