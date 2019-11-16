	/*
	 * The interrupt vector is defined here --- you shouldn't
	 * need to add any interrupt, because they're all defined as weak
	 * symbols by default.
	 */

	.section  .isr_vec, "a", %progbits
isr_vec:
	/* Cortex interrupts */
	.word stack_end
	.word handle_reset
	.word handle_nmi
	.word handle_hardfault
	.word handle_memmanage
	.word handle_busfault
	.word handle_usagefault
	.word 0
	.word 0
	.word 0
	.word 0
	.word handle_svc
	.word handle_debugmon
	.word 0
	.word handle_pendsv
	.word handle_systick

        .word wwdg_irqhandler
        .word pvd_irqhandler
        .word tamp_stamp_irqhandler
        .word rtc_wkup_irqhandler
        .word flash_irqhandler
        .word rcc_irqhandler
        .word exti0_irqhandler
        .word exti1_irqhandler
        .word exti2_irqhandler
        .word exti3_irqhandler
        .word exti4_irqhandler
        .word dma1_stream0_irqhandler
        .word dma1_stream1_irqhandler
        .word dma1_stream2_irqhandler
        .word dma1_stream3_irqhandler
        .word dma1_stream4_irqhandler
        .word dma1_stream5_irqhandler
        .word dma1_stream6_irqhandler
        .word adc_irqhandler
        .word 0
        .word 0
        .word 0
        .word 0
        .word exti9_5_irqhandler
        .word tim1_brk_tim9_irqhandler
        .word tim1_up_tim10_irqhandler
        .word tim1_trg_com_tim11_irqhandler
        .word tim1_cc_irqhandler
        .word tim2_irqhandler
        .word tim3_irqhandler
        .word tim4_irqhandler
        .word i2c1_ev_irqhandler
        .word i2c1_er_irqhandler
        .word i2c2_ev_irqhandler
        .word i2c2_er_irqhandler
        .word spi1_irqhandler
        .word spi2_irqhandler
        .word usart1_irqhandler
        .word usart2_irqhandler
        .word 0
        .word exti15_10_irqhandler
        .word rtc_alarm_irqhandler
        .word otg_fs_wkup_irqhandler
        .word 0
        .word 0
        .word 0
        .word 0
        .word dma1_stream7_irqhandler
        .word 0
        .word sdio_irqhandler
        .word tim5_irqhandler
        .word spi3_irqhandler
        .word 0
        .word 0
        .word 0
        .word 0
        .word dma2_stream0_irqhandler
        .word dma2_stream1_irqhandler
        .word dma2_stream2_irqhandler
        .word dma2_stream3_irqhandler
        .word dma2_stream4_irqhandler
        .word 0
        .word 0
        .word 0
        .word 0
        .word 0
        .word 0
        .word otg_fs_irqhandler
        .word dma2_stream5_irqhandler
        .word dma2_stream6_irqhandler
        .word dma2_stream7_irqhandler
        .word usart6_irqhandler
        .word i2c3_ev_irqhandler
        .word i2c3_er_irqhandler
        .word 0
        .word 0
        .word 0
        .word 0
        .word 0
        .word 0
        .word 0
        .word fpu_irqhandler
        .word 0
        .word 0
        .word spi4_irqhandler

	/*
	 * default handlers -- if these aren't defined elsewhere,
	 * they'll just infinite loop (so you can boot up gdb and see
	 * what happened).
	 */
	.weak handle_nmi
	.thumb_set handle_nmi, handle_default
	.weak handle_hardfault
	.thumb_set handle_hardfault, handle_default
	.weak handle_memmanage
	.thumb_set handle_memmanage, handle_default
	.weak handle_busfault
	.thumb_set handle_busfault, handle_default
	.weak handle_usagefault
	.thumb_set handle_usagefault, handle_default
	.weak handle_svc
	.thumb_set handle_svc, handle_default
	.weak handle_debugmon
	.thumb_set handle_debugmon, handle_default
	.weak handle_pendsv
	.thumb_set handle_pendsv, handle_default
	.weak handle_systick
	.thumb_set handle_systick, handle_default

        .weak wwdg_irqhandler
        .thumb_set wwdg_irqhandler, handle_default
        .weak pvd_irqhandler
        .thumb_set pvd_irqhandler, handle_default
        .weak tamp_stamp_irqhandler
        .thumb_set tamp_stamp_irqhandler, handle_default
        .weak rtc_wkup_irqhandler
        .thumb_set rtc_wkup_irqhandler, handle_default
        .weak flash_irqhandler
        .thumb_set flash_irqhandler, handle_default
        .weak rcc_irqhandler
        .thumb_set rcc_irqhandler, handle_default
        .weak exti0_irqhandler
        .thumb_set exti0_irqhandler, handle_default
        .weak exti1_irqhandler
        .thumb_set exti1_irqhandler, handle_default
        .weak exti2_irqhandler
        .thumb_set exti2_irqhandler, handle_default
        .weak exti3_irqhandler
        .thumb_set exti3_irqhandler, handle_default
        .weak exti4_irqhandler
        .thumb_set exti4_irqhandler, handle_default
        .weak dma1_stream0_irqhandler
        .thumb_set dma1_stream0_irqhandler, handle_default
        .weak dma1_stream1_irqhandler
        .thumb_set dma1_stream1_irqhandler, handle_default
        .weak dma1_stream2_irqhandler
        .thumb_set dma1_stream2_irqhandler, handle_default
        .weak dma1_stream3_irqhandler
        .thumb_set dma1_stream3_irqhandler, handle_default
        .weak dma1_stream4_irqhandler
        .thumb_set dma1_stream4_irqhandler, handle_default
        .weak dma1_stream5_irqhandler
        .thumb_set dma1_stream5_irqhandler, handle_default
        .weak dma1_stream6_irqhandler
        .thumb_set dma1_stream6_irqhandler, handle_default
        .weak adc_irqhandler
        .thumb_set adc_irqhandler, handle_default
        .weak exti9_5_irqhandler
        .thumb_set exti9_5_irqhandler, handle_default
        .weak tim1_brk_tim9_irqhandler
        .thumb_set tim1_brk_tim9_irqhandler, handle_default
        .weak tim1_up_tim10_irqhandler
        .thumb_set tim1_up_tim10_irqhandler, handle_default
        .weak tim1_trg_com_tim11_irqhandler
        .thumb_set tim1_trg_com_tim11_irqhandler, handle_default
        .weak tim1_cc_irqhandler
        .thumb_set tim1_cc_irqhandler, handle_default
        .weak tim2_irqhandler
        .thumb_set tim2_irqhandler, handle_default
        .weak tim3_irqhandler
        .thumb_set tim3_irqhandler, handle_default
        .weak tim4_irqhandler
        .thumb_set tim4_irqhandler, handle_default
        .weak i2c1_ev_irqhandler
        .thumb_set i2c1_ev_irqhandler, handle_default
        .weak i2c1_er_irqhandler
        .thumb_set i2c1_er_irqhandler, handle_default
        .weak i2c2_ev_irqhandler
        .thumb_set i2c2_ev_irqhandler, handle_default
        .weak i2c2_er_irqhandler
        .thumb_set i2c2_er_irqhandler, handle_default
        .weak spi1_irqhandler
        .thumb_set spi1_irqhandler, handle_default
        .weak spi2_irqhandler
        .thumb_set spi2_irqhandler, handle_default
        .weak usart1_irqhandler
        .thumb_set usart1_irqhandler, handle_default
        .weak usart2_irqhandler
        .thumb_set usart2_irqhandler, handle_default
        .weak exti15_10_irqhandler
        .thumb_set exti15_10_irqhandler, handle_default
        .weak rtc_alarm_irqhandler
        .thumb_set rtc_alarm_irqhandler, handle_default
        .weak otg_fs_wkup_irqhandler
        .thumb_set otg_fs_wkup_irqhandler, handle_default
        .weak dma1_stream7_irqhandler
        .thumb_set dma1_stream7_irqhandler, handle_default
        .weak sdio_irqhandler
        .thumb_set sdio_irqhandler, handle_default
        .weak tim5_irqhandler
        .thumb_set tim5_irqhandler, handle_default
        .weak spi3_irqhandler
        .thumb_set spi3_irqhandler, handle_default
        .weak dma2_stream0_irqhandler
        .thumb_set dma2_stream0_irqhandler, handle_default
        .weak dma2_stream1_irqhandler
        .thumb_set dma2_stream1_irqhandler, handle_default
        .weak dma2_stream2_irqhandler
        .thumb_set dma2_stream2_irqhandler, handle_default
        .weak dma2_stream3_irqhandler
        .thumb_set dma2_stream3_irqhandler, handle_default
        .weak dma2_stream4_irqhandler
        .thumb_set dma2_stream4_irqhandler, handle_default
        .weak otg_fs_irqhandler
        .thumb_set otg_fs_irqhandler, handle_default
        .weak dma2_stream5_irqhandler
        .thumb_set dma2_stream5_irqhandler, handle_default
        .weak dma2_stream6_irqhandler
        .thumb_set dma2_stream6_irqhandler, handle_default
        .weak dma2_stream7_irqhandler
        .thumb_set dma2_stream7_irqhandler, handle_default
        .weak usart6_irqhandler
        .thumb_set usart6_irqhandler, handle_default
        .weak i2c3_ev_irqhandler
        .thumb_set i2c3_ev_irqhandler, handle_default
        .weak i2c3_er_irqhandler
        .thumb_set i2c3_er_irqhandler, handle_default
        .weak fpu_irqhandler
        .thumb_set fpu_irqhandler, handle_default
        .weak spi4_irqhandler
        .thumb_set spi4_irqhandler, handle_default

	.text
handle_default:
	b handle_default
