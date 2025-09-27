<x-filament-panels::page.simple>
    <div class="min-h-screen bg-gray-50 dark:bg-gray-900 flex items-center justify-center">
        <div class="w-full max-w-6xl mx-auto p-4 lg:grid lg:grid-cols-2 lg:gap-12">

            {{-- Columna Izquierda: Formulario de Login --}}
            <div class="flex items-center justify-center lg:col-span-1">
                <div class="w-full max-w-md p-8 space-y-6 bg-white rounded-2xl shadow-xl dark:bg-gray-800">
                    
                    {{-- Logo y Título --}}
                    <div class="text-center">
                        <a href="{{ route('filament.admin.auth.login') }}" class="inline-block">
                            <x-filament-panels::logo class="h-12 w-auto mx-auto" />
                        </a>
                        <h2 class="mt-6 text-2xl font-bold tracking-tight text-gray-900 dark:text-white">
                            {{ __('filament-panels::pages/auth/login.title') }}
                        </h2>
                    </div>

                    {{-- Formulario --}}
                    <form wire:submit.prevent="authenticate" class="space-y-6">
                        {{ \Filament\Support\Facades\FilamentView::renderHook('panels::auth.login.form.before') }}

                        {{ $this->form }}

                        <div class="flex items-center justify-between text-sm">
                            <div class="flex items-center">
                                {{ $this->form->getComponent('remember') }}
                            </div>
                            <a href="{{ route('filament.admin.auth.password-reset.request') }}" class="font-medium text-primary-600 hover:text-primary-500 dark:text-primary-500 dark:hover:text-primary-400">
                                {{ __('filament-panels::pages/auth/login.actions.request_password_reset.label') }}
                            </a>
                        </div>

                        <x-filament-panels::form.actions 
                            :actions="$this->getFormActions()"
                            :full-width="true"
                        />

                        {{ \Filament\Support\Facades\FilamentView::renderHook('panels::auth.login.form.after') }}
                    </form>

                </div>
            </div>

            {{-- Columna Derecha: Panel Ilustrativo (visible en lg+) --}}
            <div class="hidden lg:flex lg:items-center lg:justify-center lg:col-span-1">
                <div class="w-full max-w-md text-white p-10 rounded-2xl" style="background: linear-gradient(135deg, var(--f-color-primary-600), var(--f-color-primary-400));">
                    <div class="flex items-center justify-center mb-8">
                         <x-filament-panels::logo class="h-16 w-auto" />
                    </div>
                    <div class="prose prose-invert">
                        <h3 class="text-2xl font-bold">Bienvenido a {{ config('app.name', 'CADEP') }}</h3>
                        <p class="mt-4 text-primary-100">Gestiona pacientes, citas y donaciones de forma centralizada y eficiente.</p>
                        <ul class="mt-6 space-y-3">
                            <li class="flex items-start">
                                <svg class="w-5 h-5 mr-3 mt-1 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path></svg>
                                <span>Acceso rápido y seguro a la información.</span>
                            </li>
                            <li class="flex items-start">
                                <svg class="w-5 h-5 mr-3 mt-1 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path></svg>
                                <span>Interfaz optimizada para todos tus dispositivos.</span>
                            </li>
                            <li class="flex items-start">
                                <svg class="w-5 h-5 mr-3 mt-1 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path></svg>
                                <span>Herramientas potentes para una gestión eficaz.</span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

        </div>
    </div>
</x-filament-panels::page.simple>
